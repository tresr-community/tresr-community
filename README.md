# tresr community

Welcome to the tresr community website, an **unofficial** fan-made project that showcases projects built by tresr community members.

**DISCLAIMER:** _This project is in no-way officially endorsed or affiliated with [tresr](https://tresr.io/) and is purely a fan-made project._

## Contributing

Contributions are welcome and encouraged! 🥳

## Links

- [Preview](https://preview.tresr.community)
- [Production](https://tresr.community)

## Development

Local development instructions for working with this repository.

- Install the dependencies

```bash
hugo mod clean
go mod download -x
hugo mod get ./...
hugo mod tidy
hugo mod vendor
hugo mod graph
```

- Run your own local instance using [hugo](https://gohugo.io)

```bash
hugo server --environment development
```

- Browse to the site running on `localhost`

```bash
open http://localhost:1313/
```

## Updating

- To update dependencies

```bash
# Update Go
rm -rf _vendor
hugo mod clean --all
hugo mod get -u ./...
hugo mod tidy
hugo mod vendor
```

## Keys

To update the key images;

```bash
pushd static/img/keys

./download.sh

popd
```

## CI

### GitHub Actions

There is an included workflow for Cloudflare Pages that will deploy the site.

## Theme

The official documentation for this theme (Phantom) can be found at [gethugothemes](https://docs.gethugothemes.com/phantom).
