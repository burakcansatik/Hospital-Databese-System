#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_NAME_LENGTH 100
#define FILE_NAME "hastalar.txt"


typedef struct {
    char tc[12]; 
    char ad_soyad[MAX_NAME_LENGTH];
    char servis[MAX_NAME_LENGTH];
    int id;
} Hasta;

// Rastgele ID üretme fonksiyonu
int generateRandomID() {
    return rand() % 10000; 
}


int validateTC(char *tc) {
    int length = strlen(tc);
    if (length != 11) {
        printf("Hata: TC kimlik numarasi 11 karakter olmalidir. Lutfen tekrar girin.\n");
        return 0;
    }
    return 1;
}


void dosyayaYaz(Hasta h) {
    FILE *file = fopen(FILE_NAME, "a");
    if (file == NULL) {
        printf("Dosya açma hatasi!\n");
        return;
    }
    fprintf(file, "%s,%s,%s,%d\n", h.tc, h.ad_soyad, h.servis, h.id);
    fclose(file);
}


int acildeYatanHastaSayisi() {
    FILE *file = fopen(FILE_NAME, "r");
    if (file == NULL) {
        printf("Dosya açma hatasi!\n");
        return 0;
    }

    char line[256];
    int count = 0;
    while (fgets(line, sizeof(line), file)) {
        char *servis = strtok(line, ",");
        servis = strtok(NULL, ",");
        servis = strtok(NULL, ",");
        if (strcmp(servis, "Acil") == 0) {
            count++;
        }
    }
    fclose(file);
    return count;
}

int main() {
    srand(time(NULL)); 

    Hasta yeniHasta;
    int valid = 0;

    do {
        printf("TC kimlik numarasi girin (11 haneli): ");
        scanf("%s", yeniHasta.tc);
        valid = validateTC(yeniHasta.tc);
    } while (!valid);

    printf("Ad ve soyad girin: ");
    scanf(" %[^\n]", yeniHasta.ad_soyad);
    printf("Servis girin: ");
    scanf("%s", yeniHasta.servis);

    yeniHasta.id = generateRandomID();

    dosyayaYaz(yeniHasta);

    printf("Hasta bilgileri kaydedildi.\n");
    printf("Acilde yatan hasta sayisi: %d\n", acildeYatanHastaSayisi());

    return 0;
}
