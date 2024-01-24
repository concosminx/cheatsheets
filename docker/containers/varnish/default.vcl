vcl 4.0;

backend default {
    .host = "ghost:2368";
}
sub vcl_recv {
    # Do not cache the admin and preview pages
    if (req.url ~ "^/ghost($|/.*)" ||
        req.url ~ "^/p($|/.*)" ||
        req.url ~ "^/admin($|/.*)" ||
        req.url == "/"
        ) {
           return (pass);
    }
    if (req.url ~ "testclear") {
        ban("req.http.host == mysite.com");
        return(synth(200, "Cache was cleared by Rest call"));
    }
}