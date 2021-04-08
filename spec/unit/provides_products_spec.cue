// TEST IDENTITY minimum path
provides: "index.html"

// TEST single TrackedContent
provides: {
  path: "index.html"
}
// EXPECTS
provides: {
  path: "index.html"
  tracked: true
}

// TEST single Output
provides: {
  path: "dist/*"
  from: build: "make"
}
// EXPECTS
provides: {
  path: "dist/*"
  from: build: "make"
  tracked: false
}

// TEST IDENTITY array of structs
provides: [
  {
    path: "dist/*"
    from: build: "make"
  },
  {
    path: "index.html"
  }
]
// EXPECTS
provides: [
  {
    path: "dist/*"
    from: build: "make"
    tracked: false
  },
  {
    path: "index.html"
    tracked: true
  }
]

// TEST IDENTITY array of paths
provides: [
  "index.html",
  "dist/*"
]

// TEST mixed array
provides: [
  "index.html",
  {
    path: "dist/*"
    from: build: "make"
  }
]

// EXPECTS
provides: [
  "index.html",
  {
    path: "dist/*"
    from: build: "make"
    tracked: false
  }
]
