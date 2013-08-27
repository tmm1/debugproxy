## debugproxy

TCP man in the middle proxy with SSL support.

### usage

```
$ debugproxy localhost:8080 google.com:80 > google.debugproxy &

$ curl -H "Host: google.com" http://localhost:8080/
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

$ cat google.debugproxy
[:<<, :connected]
[:>>, :connecting, "google.com", "80"]
[:<<, "GET / HTTP/1.1\r\nUser-Agent: curl/7.24.0 (x86_64-apple-darwin12.0) libcurl/7.24.0 OpenSSL/0.9.8x zlib/1.2.5\r\nAccept: */*\r\nHost: google.com\r\n\r\n"]
[:>>, :connected]
[:>>, "HTTP/1.1 301 Moved Permanently\r\nLocation: http://www.google.com/\r\nContent-Type: text/html; charset=UTF-8\r\nDate: Tue, 27 Aug 2013 23:30:36 GMT\r\nExpires: Thu, 26 Sep 2013 23:30:36 GMT\r\nCache-Control: public, max-age=2592000\r\nServer: gws\r\nContent-Length: 219\r\nX-XSS-Protection: 1; mode=block\r\nX-Frame-Options: SAMEORIGIN\r\nAlternate-Protocol: 80:quic\r\n\r\n<HTML><HEAD><meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\">\n<TITLE>301 Moved</TITLE></HEAD><BODY>\n<H1>301 Moved</H1>\nThe document has moved\n<A HREF=\"http://www.google.com/\">here</A>.\r\n</BODY></HTML>\r\n"]
[:<<, :unbind]
[:>>, :unbind]
```
