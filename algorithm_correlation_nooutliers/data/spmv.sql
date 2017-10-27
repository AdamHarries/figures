select id, time, kernel, matrix, global, local, iteration  trial from t_pact_results where
experiment_id = "2bfd49f63cb7ad1d11154ffeacf68240a12d7ed0-2017-03-07T17:50+00:00" and
statistic = "RAW_RESULT" and
correct = "correct" and matrix != "G35.mtx" and matrix != "ca-GrQc.mtx" and matrix != "G51.mtx"; 
