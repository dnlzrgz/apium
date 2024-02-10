# Delete all compiled Python files
clean:
	@echo "🧹 Cleaning up..."
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete
	@echo "✨ Clean up complete!"

# Lint using Ruff
lint:
	@echo "🔍 Linting..."
	ruff . --fix
	djhtml .
	@echo "✨ Linting complete!"

# Update dependencies and pre-commit
update:
	@echo "🔄 Updating dependencies and pre-commit..."
	poetry update
	pre-commit autoupdate
	@echo "✨ Update complete!"

# Download Tailwind CSS cli
download-tailwind:
	@echo "🛠️ Installing Tailwind CSS..."
	curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/download/v3.4.1/tailwindcss-linux-x64
	chmod +x tailwindcss-linux-x64
	mv tailwindcss-linux-x64 tailwindcss
	@echo "✨ Tailwind CSS installed!"

# Download v1.9.10 htmx script
download-htmx:
	@echo "📥 Downloading htmx script..."
	curl -sL https://unpkg.com/htmx.org@1.9.10/dist/htmx.min.js -o static/js/htmx.js
	curl -sL https://unpkg.com/htmx.org/dist/ext/debug.js -o static/js/debug.js
	@echo "✨ htmx script downloaded and saved!"

# Run Tailwind CSS minification
tailwind-min:
	@echo "🚀 Running Tailwind CSS minification..."
	./tailwindcss -i ./static/css/input.css -o ./static/css/output.min.css --minify
	@echo "✨ Tailwind CSS minification complete!"

# Run Tailwind CSS in watch mode
tailwind-watch:
	@echo "🚀 Running Tailwind CSS in watch mode..."
	./tailwindcss -i ./static/css/input.css -o ./static/css/output.css --watch
	@echo "✨ Tailwind CSS watch mode started!"

# Collect static files
collect:
	@echo "📦 Collecting static files..."
	python manage.py collectstatic
	@echo "✨ Static files collected!"

# Start local Docker compose
local-start:
	@echo "🚀 Starting local Docker compose..."
	docker compose -f local.yaml up -d --build
	@echo "✨ Local Docker compose started!"

# Stop local Docker compose
local-stop:
	@echo "🛑 Stopping local Docker compose..."
	docker compose -f local.yaml down
	@echo "✨ Local Docker compose stopped!"

# Watch local Docker compose logs
local-logs:
	@echo "👀 Watching container logs..."
	docker compose -f local.yaml logs -f
	@echo "✨ Watching container logs finished!"

# Setup project with dependencies, Tailwind CSS and Alpine.js for local development
setup:
	@make download-tailwind
	@make download-htmx
	poetry install
	pre-commit install
	pre-commit run --all-files
	@echo "✨ Project setup complete!"
