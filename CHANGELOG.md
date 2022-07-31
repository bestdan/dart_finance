## 0.0.1 2022-07-31
* First version
* Define `Return` and `ReturnStream` types


---

* **BREAKING** Removed `Shelf` prefix from all classes.
* **BREAKING** `Response` has drastically different constructors.
* *NEW!* `Response` now accepts a body of either `String` or
  `Stream<List<int>>`.
* *NEW!* `Response` now exposes `encoding` and `mimeType`.
