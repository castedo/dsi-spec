# Discussion

## Optional DSI Prefix

Users may choose to use a DSI with or without
a prefix depending on the application context.
An intuitive prefix is `dsi:`, reflecting the acronym "DSI".
For convenience, some websites offer a URL that acts as a DSI prefix.

As of 2023, the [Hidos](https://pypi.org/project/hidos/) tool supports DSIs
with or without the `dsi:` prefix in the `find` subcommand. For example:

```bash
$ hidos find dsi:1wFGhvmv8XZfPx0O5Hya2e9AyXo
gh-703611066 https://github.com/digital-successions/1wFGhvmv8XZfPx0O5Hya2e9AyXo.git
```

As of 2023, the website `perm.pub` supports a URL-based prefix `https://perm.pub/`,
as shown in the following example:

```bash
$ firefox https://perm.pub/1wFGhvmv8XZfPx0O5Hya2e9AyXo
```


## Future Extensions

To accommodate future enhancements,
there are three methods for extending the textual representation of a DSI:

* Use a character that is neither a slash (`/`) nor one of the 64 base64url characters.
* Vary the number of characters from 27.
* Make the 27th character one of the 48 base64url characters that never appear
  as the last character in a base64url encoding of 40 bytes
  (that is, any base64url character other than
  `A`, `E`, `I`, `M`, `Q`, `U`, `Y`, `c`, `g`, `k`, `o`, `s`, `w`, `0`, `4`, or `8`).


## Use of Base64url Over Hexadecimal

The textual identifier uses "base64url" (Base 64 with a URL and filename safe alphabet) as
specified in RFC 4648 [@rfc4648].
Both base64url and hexadecimal have their advantages and disadvantages.

The main downside to base64url is its susceptibility to copy
errors when copying relies on human sight.
Certain fonts make a poor distinction between some characters.
For example, some popular sans serif fonts make no visual distinction
between capital 'I' and lowercase 'l'.

That said, creators of a new document succession are not obligated to use
a specific DSI.
If a DSI is unsuitable, a new one can be generated with ease.

The main advantage of base64url is its brevity,
with only 27 characters compared to 40 in hexadecimal.
Since DSIs are used in contexts similar to DOIs,
a 27-character identifier is more likely to be acceptable,
as it is comparable to the length of a long DOI.
Additionally, a shorter ID is more suitable for display on mobile devices,
reducing the likelihood of
truncation, horizontal scrolling, or the need for very small fonts.

The choice of base64url is partly made on the belief that
technology trends mitigate the copy-by-human-sight copying issue:

1) Use of hyperlinks, copy-and-paste, and QR codes.

2) Tools that generate websites and PDFs allow customization of fonts.

3) Human-to-computer interfaces are incorporating
features like autocomplete and typo correction to mitigate input errors.
