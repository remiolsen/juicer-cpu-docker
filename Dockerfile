FROM conda/miniconda3:latest

LABEL author="Remi-Andre Olsen" \
      maintainer="remi-andre.olsen@scilifelab.se" \
      homepage="https://github.com/remiolsen/juicer-cpu-docker" \
      juicer-version="1.6" \
      juicer-commit="2afef51"

RUN apt-get update && \
    apt-get install -y git openjdk-8-jdk coreutils gawk wget && \
    conda config --add channels bioconda && \
    conda install --yes bwa=0.7.17 samtools=0.1.19 && \
    echo 'alias awk=gawk' >> $HOME/.bashrc && \
    apt-get clean
RUN cd /opt && git clone https://github.com/theaidenlab/juicer.git && cd juicer && \
    ln -s CPU scripts && \
    cd scripts/common && \
    wget -O juicer_tools.jar http://hicfiles.tc4ga.com.s3.amazonaws.com/public/juicer/juicer_tools.1.6.2_jcuda.0.7.0.jar

ENV PATH="/opt/juicer/scripts/:$PATH"

