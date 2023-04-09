# c4ij-r

C language for IchigoJam R

## Setup (Mac)

[Homebrew](https://brew.sh/)
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

[Deno](https://deno.land/)
```sh
curl -fsSL https://deno.land/x/install/install.sh | sh
```

```sh
brew install riscv-gnu-toolchain
```

## Build

```sh
make
```

## Sample

add 1
```c
__attribute__ ((section(".main")))
int main(int param) {
  return param + 1;
}
```

mul self
```c
__attribute__ ((section(".main")))
int main(int param) {
  return param * param;
}
```

fibonacci
```c
int fib(int n) {
  if (n < 2) {
    return n;
  }
  return fib(n - 1) + fib(n - 2);
}
__attribute__ ((section(".main")))
int main(int param) {
  return fib(param);
}
```
