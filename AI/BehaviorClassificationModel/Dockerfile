FROM python:3.11-slim

RUN apt-get update && apt-get install -y libgl1-mesa-glx libglib2.0-0 && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user PATH=/home/user/.local/bin:$PATH
WORKDIR $HOME/app

COPY --chown=user requirements.txt $HOME/app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r requirements.txt

RUN mkdir -p $HOME/.deepface/weights

COPY --chown=user ./app $HOME/app/app
COPY --chown=user ./models $HOME/app/models

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "7860"]