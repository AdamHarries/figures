select 
lMatrix as matrix,
"Lift" as ktype,
"Lift" as framework,
cuMin/lMin as ratio
from 
(
	select * from
	( 
		select 
		matrix as lMatrix,
		min(time) as lMin
		from
		t_pact_results
		where 
		experiment_id = "2bfd49f63cb7ad1d11154ffeacf68240a12d7ed0-2017-03-07T17:50+00:00" or
		experiment_id = "fa4443d6b072b64ee3fa23acb6b30756454f1293-2017-03-28T20:39+01:00"
		group by matrix
	) as Lift
	left join
	(
		select
		matrix as cuMatrix,
		min(time) as cuMin
		from 
		t_pact_results
		where 
		experiment_id = "a172cf9066e057db15e27b17a9d80379c422fdb6-2017-03-08T15:57+00:00" or
		experiment_id = "a172cf9066e057db15e27b17a9d80379c422fdb6-2017-03-30T21:42+01:00"
		group by matrix
	) as cuSPARSE
	on 
	Lift.lMatrix = cuSPARSE.cuMatrix
)as result order by cuMin;
