cd /d C:
"C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe" -i 0 --loop-ms=1000 --format=csv,noheader --query-gpu=power.draw
pause