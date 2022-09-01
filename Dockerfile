FROM conda/miniconda3:latest

LABEL author="Remi-Andre Olsen" \
      maintainer="remi-andre.olsen@scilifelab.se" \
      homepage="https://github.com/remiolsen/juicer-cpu-docker" \
      juicer-version="2.0" \
      juicer-commit="5a471a4"

RUN apt-get update && \
    apt-get install -y git openjdk-8-jdk coreutils gawk wget && \
    conda config --add channels bioconda && \
    conda install --yes bioconda::samtools=1.9 bioconda::bwa=0.7.17 && \
    echo 'alias awk=gawk' >> $HOME/.bashrc && \
    apt-get clean
RUN cd / && git clone https://github.com/theaidenlab/juicer.git && mv juicer aidenlab && cd aidenlab && \
    ln -s CPU scripts && \
    cd scripts/common && \
    wget -O juicer_tools.jar https://github.com/aidenlab/Juicebox/releases/download/v2.17.00/juicer_tools_2.17.00.jar && \
    ln -s /aidenlab /opt/juicer

ENV PATH="/aidenlab/scripts/:$PATH"
