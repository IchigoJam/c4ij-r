# c4ij-r

- C language environment for IchigoJam R
- C言語開発環境 for IchigoJam R

## Setup (Mac)

[Homebrew](https://brew.sh/) - 開発ツールインストール用ツール
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

[Deno](https://deno.land/) - JavaScript開発ツール
```sh
curl -fsSL https://deno.land/x/install/install.sh | sh
```

[riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain) - RISC-V用Cコンパイラ
```sh
brew install riscv-gnu-toolchain
```

## Build

1. edit [main.c](main.c)
2. build!
```sh
make
```
3. type the dump in IchigoJam
4. RUN on IchigoJam
```
?USR(#700,100)
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
