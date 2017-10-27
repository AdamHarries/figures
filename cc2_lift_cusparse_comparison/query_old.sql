select * from 
(
	SELECT 
		Apart.matrix as matrix,
		clSparse.variance as variance,
		clSparse.height as height,
		clSparse.runtime / Apart.time as ratio,
		"clSPARSE" as framework,
		Apart.ktype as ktype
	FROM 
	(
		(
			select min(time) as time, matrix,
			"all kernels" as ktype
			from t_pact_results where correct = "correct" 
			group by matrix
		) union (
			select min(time) as time, matrix,
			"static" as ktype
			from t_pact_results where correct = "correct" and
			(kernel not regexp binary "alcl") and
			(kernel not regexp binary "awrg") and
			(kernel not regexp binary "awrp") and
			(kernel not regexp binary "glb")
			group by matrix
		)
	) as Apart
	LEFT JOIN 
	(
		SELECT 
	        M.matrix_filename as matrix,
	        M.variance_width as variance,
			M.height as height,
			min(runtime) as runtime
		FROM
			clSPARSE_runs R,
			platforms P,
			matrices M
		where
			R.platform = 4 and
			R.matrix = M.matrix_id and
			R.adaptive = 1
		group by 
			R.matrix
	) as clSparse
	ON 
	Apart.matrix = clSparse.matrix
	ORDER BY 
	variance, matrix
) as result;-- as cuRatio union (
-- 	SELECT 
-- 		Apart.matrix as matrix,
-- 		clSparse.variance as variance,
-- 		clSparse.height as height,
-- 		clSparse.runtime / Apart.time as ratio,
-- 		"clSPARSE" as framework
-- 	FROM 
-- 	(
-- 		select min(time) as time, matrix 
-- 		from sc_spmv_31st where correct = 1 
-- 		group by matrix
-- 	) as Apart
-- 	LEFT JOIN 
-- 	(
-- 		SELECT 
-- 	        M.matrix_filename as matrix,
-- 	        M.variance_width as variance,
-- 			M.height as height,
-- 			min(runtime) as runtime
-- 		FROM
-- 			clSPARSE_runs R,
-- 			platforms P,
-- 			matrices M
-- 		where
-- 			R.platform = 7 and
-- 			R.matrix = M.matrix_id
-- 		group by 
-- 			R.matrix
-- 	) as clSparse
-- 	ON 
-- 	Apart.matrix = clSparse.matrix
-- 	ORDER BY 
-- 	variance, matrix
-- ) order by framework, variance, matrix;
