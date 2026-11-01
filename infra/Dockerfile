FROM nginx:1.27-alpine

# Copy the static site into nginx's web root
COPY index.html /usr/share/nginx/html/index.html

# Must match containerPort / targetPort in app.yaml
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
