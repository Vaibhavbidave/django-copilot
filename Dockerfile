# Use a smaller Python base image
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 

# Set the working directory
WORKDIR /code

# Copy and install dependencies with caching for faster builds
COPY requirements.txt /code/
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --no-cache-dir -r requirements.txt

# Copy the entire project
COPY --chown=python:python . /code/

# Set a non-root user for better security
USER python

# Expose the Django port
EXPOSE 8000

# Default command to run the server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
