#include <stdio.h>
//* Towers of Hanoi: ex1.c *//

void hanoi(int, char, char, char);

int main() {
   int N;

   scanf("%d", &N);
   printf("\n");
   hanoi(N, '1', '2', '3');
}

void hanoi(int N, char A, char B, char C) {
   if (N > 0) {
   hanoi(N - 1, A, C, B);
   printf("Move disk %d from Peg %c to Peg %c\n", N, A, C);
   hanoi(N - 1, B, A, C);
}
}

