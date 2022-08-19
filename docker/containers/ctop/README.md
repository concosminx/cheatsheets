# ctop - Top-like interface for container metrics

- See [source](https://github.com/bcicen/ctop) for extra info.
- Run, from docker: 
```bash
docker run --rm -ti \
  --name=ctop \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  quay.io/vektorlab/ctop:latest
```