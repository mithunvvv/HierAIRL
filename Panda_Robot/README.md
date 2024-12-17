https://github.com/qgallouedec/panda-gym

https://github.com/DLR-RM/rl-baselines3-zoo

https://huggingface.co/sb3/tqc-PandaPickAndPlace-v1

https://huggingface.co/chencliu/tqc-PandaPickAndPlace-v3

download model:
python -m rl_zoo3.load_from_hub --algo tqc --env PandaPickAndPlace-v3 -orga chencliu -f logs/

evaluation:
python -m rl_zoo3.enjoy --algo tqc --env PandaPickAndPlace-v3 -f logs/ --no-render