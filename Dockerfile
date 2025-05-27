# Base Image
FROM python:3.12-slim

# Environment Variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    VIRTUAL_ENV=/app/.venv \
    PATH="/root/.local/bin:/app/.venv/bin:$PATH" 


# Set the working directory inside the container
WORKDIR /app


# Install uv (modern Python dependency manager)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Copy application code
COPY pyproject.toml .

# Create and set up virtual environment
RUN uv venv && \
    uv sync && \
    uv build

# Copy your entire application code
COPY . .

# Command to run your Streamlit application
# Replace `your_streamlit_app.py` with the actual name of your Streamlit file
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]