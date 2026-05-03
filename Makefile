NAME_BANK = bank
NAME_BATCH = batch

CC = cobc
CFLAGS = -x

SRC_BANK = bank.cbl
SRC_BATCH = batch.cbl

all: $(NAME_BANK) $(NAME_BATCH)

$(NAME_BANK): $(SRC_BANK)
	$(CC) $(CFLAGS) $(SRC_BANK)

$(NAME_BATCH): $(SRC_BATCH)
	$(CC) $(CFLAGS) $(SRC_BATCH)

clean:
	rm -f $(NAME_BANK) $(NAME_BATCH)

fclean: clean
	rm -f transactions.txt
	@echo "Cleaned up transactions.txt"

re: clean all

.PHONY: all clean fclean re
