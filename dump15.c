#include <stdio.h>

int main(int argc, char** argv) {
  if (argc < 2) {
    printf("dump15 [fn]\n");
    return 1;
  }
  const char* fn = argv[1];
  FILE* fp = fopen(fn, "rb");

  int adr = 0x700;
  int line = 100;
  for (int idx = 0;; idx += 16) {
    printf("%d POKE#%X", line + idx / 16 * 10, adr + idx);
    int n;
    for (int i = 0; i < 16; i++) {
      n = fgetc(fp);
      if (n == EOF) break;
      printf(",#%02X", n);
      //printf(",%d", n);
    }
    printf("\n");
    if (n == EOF) break;
  }
  fclose(fp);
  return 0;
}
