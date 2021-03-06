echo "RUNNING TEST ONE -> SDF"
curl -X POST -H "Content-Type: application/json" --data-urlencode @smis.json "http://${DOCKER_IP:-"127.0.0.1"}:8000/rdkit_cluster/cluster_simple?threshold=0.5&fp_method=morgan&sim_method=tanimoto" > out.test_one
cmp --silent out.test_one out.test_one_check && echo "TEST PASSED" || echo "TEST FAILED"
rm out.test_one
echo "RUNNING TEST TWO -> JSON"
curl -X POST -H "Content-Type: chemical/x-mdl-sdfile" --data-urlencode @18.sdf "http://${DOCKER_IP:-"127.0.0.1"}:8000/rdkit_screen/screen_simple?smiles=CCCCCC&threshold=0.5&fp_method=morgan&sim_method=tanimoto" > out.test_two
cmp --silent out.test_two out.test_two_sdf_check && echo "TEST PASSED" || echo "TEST FAILED"
rm out.test_two
echo "RUNNING TEST THREE -> GZIP"
curl -X POST -H "Accept-Encoding: gzip" -H "Content-Type: application/json" --data-urlencode @db.json "http://${DOCKER_IP:-"127.0.0.1"}:8000/rdkit_cluster/cluster_simple?threshold=0.5&fp_method=morgan&sim_method=tanimoto" > out.test_three.gz && gzip -d out.test_three.gz
cmp --silent out.test_three out.test_three_check && echo "TEST PASSED" || echo "TEST FAILED"
rm out.test_three
echo "RUNNING TEST FOUR -> GZIP IN GZIP OUT"
curl -X POST -H "Accept-Encoding: gzip" -H "Content-Encoding: gzip" -H "Content-Type: application/json" --data-urlencode @db.json.gz "http://${DOCKER_IP:-"127.0.0.1"}:8000/rdkit_cluster/cluster_simple?threshold=0.5&fp_method=morgan&sim_method=tanimoto" > out.test_four.gz && gzip -d out.test_four.gz
cmp --silent out.test_four out.test_three_check && echo "TEST PASSED" || echo "TEST FAILED"
rm out.test_four
