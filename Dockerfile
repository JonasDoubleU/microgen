FROM jupyter/base-notebook:python-3.9.7

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

USER root
RUN apt-get update \
 && apt-get install  -yq --no-install-recommends \
    libgl1-mesa-glx \
    libfontconfig1 \
    libxrender1 \
    libosmesa6 \
    xvfb \
 && apt-get clean && rm -rf /var/lib/apt/lists/*
USER ${NB_USER}


RUN conda install -y -c conda-forge -c cadquery -c set3mah microgen

RUN pip install -r ${HOME}/examples/jupyter_notebooks/requirements.txt


WORKDIR $HOME

# allow jupyterlab for ipyvtk
ENV JUPYTER_ENABLE_LAB=yes
ENV PYVISTA_USE_IPYVTK=true