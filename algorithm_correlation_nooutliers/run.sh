cd data
./refresh_data.sh
cd ../
python3 algorithmcorrelation.py
R --no-save < correlation.R
