docker run --rm \
  -it \
  -p 4000:3000 \
  -p 4035:3035 \
  -v "$(pwd)":/home/ubuntu/repo \
  --net="mr2_default" \
  --name mr2_web_run_1 \
  ktakase00/rubypg-learn-mr2:uv-201908 \
  bash
