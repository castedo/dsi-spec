baseprint:
  pip install panflute
  BASEPRINTER_JATS=OFF baseprinter --defaults pandocin.yaml --baseprint baseprint --outdir _preview
