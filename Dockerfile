
# Technically moondream's python client now uses Onnxruntime for inference, so torch is not needed...
FROM waggle/plugin-base:1.1.1-ml-torch1.9

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Initial Deps
RUN apt-get update --fix-missing
RUN apt-get install -y wget curl pkg-config libssl-dev curl

# Update GCC via REPO (perhaps you can use this hacky way to bypass the need to compile the aforementioned)
RUN echo "deb http://ports.ubuntu.com/ubuntu-ports jammy main" | tee /etc/apt/sources.list.d/temporary-repository.list

# Python 3.10
RUN apt-get update --fix-missing
RUN apt-get install -y build-essential python3 python3-pip

RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3
RUN python3 -m pip install --upgrade pip

# Python Dependencies
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
RUN wget https://github.com/cleeuh/moondream-0.5b-for-sage-node/releases/download/resources/onnxruntime_gpu-1.19.0-cp310-cp310-linux_aarch64.whl -O onnxruntime_gpu-1.19.0-cp310-cp310-linux_aarch64.whl
RUN pip3 install onnxruntime_gpu-1.19.0-cp310-cp310-linux_aarch64.whl
RUN pip3 install numpy==1.26.4

# Model
RUN wget https://github.com/cleeuh/moondream-0.5b-for-sage-node/releases/download/resources/moondream-0_5b-int8.mf -O moondream-0_5b-int8.mf

COPY . .


# # ENTRYPOINT [ "/usr/bin/bash" ]
ENTRYPOINT ["python3", "main.py"]
# # ENTRYPOINT ["python3", "main_test.py"]
