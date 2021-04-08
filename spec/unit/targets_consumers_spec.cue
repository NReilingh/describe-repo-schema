// TEST IDENTITY single string
provides: {
  path: "index.html"
  targets: "Web Browsers"
}

// TEST IDENTITY single struct
provides: {
  path: "script.pl"
  targets: {
    description: "Perl"
    ref: "https://www.perl.org"
    exec: "./script.pl"
  }
}

// TEST IDENTITY mixed array
provides: {
  path: "install.sql"
  targets: [
    "SQL Server",
    {
      description: "Tessitura"
    }
  ]
}
