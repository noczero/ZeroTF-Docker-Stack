# pull docker imagetensorflow/tensorflow:latest-gpu-jupyter
FROM tensorflow/tensorflow:latest-gpu

# define workdir for volumes
WORKDIR /tf

# follow the tensorflow python
ENV python_version 3

# apt update
RUN apt update

# Install desired Python version (the current TF image is be based on Ubuntu at the moment)
RUN apt install -y python${python_version}

# Set default version for root user - modified version of this solution: https://jcutrer.com/linux/upgrade-python37-ubuntu1810
RUN update-alternatives --install /usr/local/bin/python python /usr/bin/python${python_version} 1

# Update pip: https://packaging.python.org/tutorials/installing-packages/#ensure-pip-setuptools-and-wheel-are-up-to-date
RUN python -m pip install --upgrade pip setuptools wheel

# By copying over requirements first, we make sure that Docker will "cache"
# our installed requirements in a dedicated FS layer rather than reinstall
# them on every build
COPY requirements.txt requirements.txt

# Install the requirements
RUN python -m pip install -r requirements.txt

# JUPYTER NOTEBOOK
RUN python -m pip install --no-cache-dir jupyter
RUN python -m pip install --no-cache-dir jupyter_http_over_ws ipykernel==5.1.1 nbformat==4.4.0
RUN jupyter serverextension enable --py jupyter_http_over_ws

# Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server --install-extension formulahendry.terminal \
    && code-server --install-extension ms-python.python \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# supervisor
RUN apt update && apt install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# jupyter port
EXPOSE 8888

# code-server
EXPOSE 8889

RUN python -m ipykernel.kernelspec
CMD ["bash", "-c", "source /etc/bash.bashrc && /usr/bin/supervisord"]
