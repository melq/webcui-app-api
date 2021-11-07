#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define INF 100000
#define TRUE 1
#define FALSE 0

#include "station.h"

int COST[N];
int VIA[N];
char USED[N];

int dijkstra(int start, int goal, int DIST[][N], int distline) {
  int min;
  int u, v;

  COST[start] = 0;
  while(1){
    min = INF;
    for(int i = 0; i < distline; i++){
      if(!USED[i] && min > COST[i]) {
        u = i;
        min = COST[i];
      }
    }
    if(u == goal){
      return COST[goal];
    }
    for(v = 0; v < distline; v++){
      if(COST[v] > DIST[u][v] + COST[u]) {
        COST[v] = DIST[u][v] + COST[u];
        VIA[v] = u;
      }
    }
    USED[u] = TRUE;
  }
}
int stop_station(int *s_renew, int *g_renew, int en) {
  int i;

  for(i = 0; i < N; i++) {
    if((strcmp(s_maebashi, eki[i]) == 0) && (en == 1)) {
      *g_renew = i;
      *s_renew = i + 1;
      break;
    }
    if((strcmp(s_isesaki, eki[i]) == 0) && (en == 2)) {
      *g_renew = i;
      *s_renew = i + 1;
      break;
    }
    if((strcmp(s_kiryu, eki[i]) == 0) && (en == 3)) {
      *g_renew = i;
      *s_renew = i + 1;
      break;
    }
    if((strcmp(s_oyama, eki[i]) == 0) && en == 4) {
      *g_renew = i;
      *s_renew = i + 1;
      break;
    }
    if((strcmp(s_takasaki, eki[i]) == 0) && en == 5) {
      *g_renew = i;
      *s_renew = i + 1;
      break;
    }
    if((strcmp(s_kiryu, eki[i]) == 0) && en == 6) {
      *g_renew = i;
      *s_renew = i + 1;
      break;
    }
  }
}
int getoff(int *s, int *d, char *argv[], int *s2, int *d2) {
  int i, j;
  int g_renew, s_renew;
  int en = 0;

  if(*s < *d) {
    for(j = 0; j < *d; j++) {
      if(j < O1) {
        if(strcmp(argv[3], maebashi[j]) == 0) {
          if(j != *d) {
            en = 1;
            *d2 = *d;
            stop_station(&s_renew, &g_renew, en);
            *d  = g_renew;
            *s2 = s_renew;
          }
        }
        /*
        else if((strncmp(argv[3], maebashi[j], 2) == 0) && en == 0) {
          printf("%s行きの%sがあります\n", s_maebashi, maebashi[j]);
        }
        */
      }
      if(j < O2) {
        if(strcmp(argv[3], isesaki[j]) == 0) {
          if(j != *d) {
            en = 2;
            *d2 = *d;
            stop_station(&s_renew, &g_renew, en);
            *d  = g_renew;
            *s2 = s_renew;
          }
        }
        /*
        else if((strncmp(argv[3], isesaki[j], 2) == 0) && en == 0) {
          printf("%s行きの%sがあります\n", s_isesaki, isesaki[j]);
        }
        */
      }
      if(j < O3) {
        if(strcmp(argv[3], kiryu1[j]) == 0) {
          if(j != *d) {
            en  = 3;
            *d2 = *d;
            stop_station(&s_renew, &g_renew, en);
            *d  = g_renew;
            *s2 = s_renew;
          }
        }
        /*
        else if((strncmp(argv[3], kiryu1[j], 2) == 0) && en == 0) {
          printf("%s行きの%sがあります\n", s_kiryu, kiryu1[j]);
        }
        */
      }
      if(j < O4) {
        if(strcmp(argv[3], oyama[j]) == 0) {
          if(j != *d) {
            en = 4;
            *d2 = *d;
            stop_station(&s_renew, &g_renew, en);
            *d  = g_renew;
            *s2 = s_renew;
          }
        }
        /*
        else if((strncmp(argv[3], oyama[j], 2) == 0) && en == 0) {
          printf("%s行きの%sがあります\n", s_oyama, oyama[j]);
        }
        */
      }
    }
  }
  else {
    for(j = 0; j < *s; j++) {
      if(j < T1) {
        if(strcmp(argv[3], takasaki[j]) == 0) {
          if(j != *s) {
            en = 5;
            *d2 = *d;
            stop_station(&s_renew, &g_renew, en);
            *d  = g_renew;
            *s2 = s_renew;
          }
        }
        /*
        else if((strncmp(argv[3], takasaki[j], 2) == 0) && en == 0) {
          printf("%s行きの%sがあります\n", s_takasaki, takasaki[j]);
        }
        */
      }
      if(j < T2) {
        if(strcmp(argv[3], kiryu2[j]) == 0) {
          if(j != *s) {
            en = 6;
            *d2 = *d;
            stop_station(&s_renew, &g_renew, en);
            *d  = g_renew;
            *s2 = s_renew;
          }
        }
        /*
        else if((strncmp(argv[3], kiryu2[j], 2) == 0) && en == 0) {
          printf("%s行きの%sがあります\n", s_kiryu, kiryu2[j]);
        }
        */
      }
    }
  }
  return 0;
}
int main(int argc, char *argv[]) {
  int i, j, k;
  int e = N - 1;
  int s, d, s2, d2;
  int node;
  int tmp[N];
  int l1 = 0;
  int l2 = 0;
  int count1 = 0;
  int count2 = 0;

  for(i = 0; i < N; i++) {
    COST[i] = INF;
    USED[i] = FALSE;
    VIA[i] = -1;
  }
  printf("%s -> %s\n", argv[1], argv[2]);
  printf("---------------\n");
  for(i = 0; i < N; i++) {
    if(strcmp(argv[1], eki[i]) == 0) {
      s = i;
    }
    if(strcmp(argv[2], eki[i]) == 0) {
      d = i;
    }
  }
  printf("最短距離 : %d 駅経由します\n", dijkstra(s, d, DIST, N));
  printf("最短経路 : ");
  node = d;
  while(1){
    node = VIA[node];
    tmp[l1] = node;
    l1++;
    count1++;
    if (node == s) break;
  }
  for(k = count1-1; k >= 0; k--) {
    printf("%s -> ", eki[tmp[k]]);
  }
  printf(" %s \n", eki[d]);
  if(d2 != 0 || s2 != 0) {
    printf("|\n");
    s = s2;
    d = d2;
    getoff(&s, &d, argv, &s2, &d2);
    printf("最短距離 : %d 駅経由します\n", dijkstra(s2, d2, DIST, N));
    printf("最短経路 : ");
    node = d2;
    while(1){
      node = VIA[node];
      tmp[l2] = node;
      l2++;
      count2++;
      if (node == s2) break;
    }
    for(k = count2-1; k >= 0; k--) {
      printf("%s -> ", eki[tmp[k]]);
    }
    printf(" %s \n", eki[d2]);
  }
  return 0;
}