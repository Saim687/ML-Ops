# # Use a lightweight Python base image
# FROM python:3.9-slim

# # Set the working directory inside the container
# WORKDIR /app

# # Copy all files from your current directory to the container
# COPY . /app 

# # Install the necessary dependencies for training and the API
# RUN pip install --no-cache-dir pandas fastapi uvicorn scikit-learn

# # Expose port 8000 as specified in the lab requirements
# EXPOSE 8000

# # Start the FastAPI application using uvicorn
# CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt && \
    pip install uvicorn

COPY train.py .
COPY app.py .
COPY config.json .
COPY dataset/ ./dataset/

# Training step - har build par chalega
RUN python train.py && ls -la && cat metrics.json

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

