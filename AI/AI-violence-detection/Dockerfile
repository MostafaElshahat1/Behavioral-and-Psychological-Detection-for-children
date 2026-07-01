# Start with a stable Python environment
FROM python:3.10

# Set the working directory inside the shipping container
WORKDIR /code

# Copy the requirements and install them
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Copy your app code and your model file into the container
COPY ./app /code/app
COPY ./mdl /code/mdl

# Hugging Face Spaces require the app to run on port 7860
# Command to run the FastAPI app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "7860"]