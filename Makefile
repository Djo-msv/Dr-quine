PROGRAMS = Colleen Grace Sully

CC       = clang
CFLAGS   = -Wall -Wextra -Werror
NASM     = nasm -f elf64

MAKEFLAGS += --no-print-directory

.PHONY: all clean fclean re header welcome program_compilation diff_maker \
		check_run $(PROGRAMS)

LOG = $(CURDIR)/logs/$(NAME).log

define wait_for
for t in $$(seq 1 100); do [ -f "$(1)" ] && break; sleep 0.1; done; sleep 0.3
endef

# ─────────────────────────────────────────────
# Colors
# ─────────────────────────────────────────────

RESET   = \033[0m
WHITE   = \033[0;97m
GREY    = \033[0;90m
MAGENTA = \033[0;95m
PURPLE  = \033[0;35m
GREEN   = \033[0;92m
RED     = \033[0;91m
CYAN    = \033[0;96m

# ─────────────────────────────────────────────
# Main
# ─────────────────────────────────────────────

all:
	@$(MAKE) header
	@$(MAKE) welcome
	@printf "\n"
	@printf "$(PURPLE)  ➜  $(WHITE)Select the program to test : $(RESET)"
	@read -r choice; \
	case "$$choice" in \
		1) $(MAKE) program_compilation NAME=Colleen;; \
		2) $(MAKE) program_compilation NAME=Grace;; \
		3) $(MAKE) program_compilation NAME=Sully;; \
		*) printf "\n$(RED)  ✗ Invalid selection.$(RESET)\n"; exit 1;; \
	esac

# Direct shortcuts: `make Colleen`, `make Grace`, `make Sully`
$(PROGRAMS):
	@$(MAKE) program_compilation NAME=$@

any:
	@$(MAKE) header
	@for program in $(PROGRAMS); do \
		$(MAKE) program_compilation NAME=$$program; \
	done

clean:
	@printf "\n$(CYAN)  Cleaning temporary files...$(RESET)\n"
	@rm -f ASM/*.o
	@rm -f C/a.out ASM/a.out
	@rm -f C/*_diff ASM/*_diff
	@rm -f C/Grace_kid.c ASM/Grace_kid.s
	@rm -rf logs
	@printf "$(GREEN)  ✓ Temporary files removed$(RESET)\n\n"

fclean: clean
	@printf "$(CYAN)  Removing compiled programs...$(RESET)\n"
	@rm -f C/Sully_* ASM/Sully_*
	@rm -f $(addprefix C/,$(PROGRAMS)) $(addprefix ASM/,$(PROGRAMS))
	@printf "$(GREEN)  ✓ All generated files removed$(RESET)\n\n"
re: fclean all

# ─────────────────────────────────────────────
# Header
# ─────────────────────────────────────────────

header:
	@printf "\n"
	@printf "$(PURPLE)╔════════════════════════════════════════════════════╗$(RESET)\n"
	@printf "$(PURPLE)║$(RESET)  ___                                               $(PURPLE)║$(RESET)\n"
	@printf "$(PURPLE)║$(RESET) (  _\`\\                            _                $(PURPLE)║$(RESET)\n"
	@printf "$(PURPLE)║$(RESET) | | ) | _ __          _ _  _   _ (_)  ___     __   $(PURPLE)║$(RESET)\n"
	@printf "$(PURPLE)║$(RESET) | | | )( '__)       /'_\` )( ) ( )| |/' _ \`\\ /'__\`\\ $(PURPLE)║$(RESET)\n"
	@printf "$(PURPLE)║$(RESET) | |_) || |         ( (_) || (_) || || ( ) |(  ___/ $(PURPLE)║$(RESET)\n"
	@printf "$(PURPLE)║$(RESET) (____/'(_)         \`\\__, |\`\\___/'(_)(_) (_)\`\\____) $(PURPLE)║$(RESET)\n"
	@printf "$(PURPLE)║$(RESET)              ______    | |                         $(PURPLE)║$(RESET)\n"
	@printf "$(PURPLE)║$(RESET)             (______)   (_)                         $(PURPLE)║$(RESET)\n"
	@printf "$(PURPLE)║$(RESET)                                                    $(PURPLE)║$(RESET)\n"
	@printf "$(PURPLE)╚════════════════════════════════════════════════════╝$(RESET)\n"

# ─────────────────────────────────────────────
# Menu
# ─────────────────────────────────────────────

welcome:
	@printf "\n"
	@printf "$(MAGENTA)  ┌─ Available programs ─┐$(RESET)\n"
	@printf "$(MAGENTA)  │$(RESET)\n"
	@printf "$(MAGENTA)  │$(RESET)  $(GREEN)1.$(RESET) $(WHITE)Colleen$(RESET)\n"
	@printf "$(MAGENTA)  │$(RESET)  $(GREEN)2.$(RESET) $(WHITE)Grace$(RESET)\n"
	@printf "$(MAGENTA)  │$(RESET)  $(GREEN)3.$(RESET) $(WHITE)Sully$(RESET)\n"
	@printf "$(MAGENTA)  │$(RESET)\n"
	@printf "$(MAGENTA)  └──────────────────────┘$(RESET)\n"

# ─────────────────────────────────────────────
# Compilation
# ─────────────────────────────────────────────

program_compilation:
	@mkdir -p logs; \
	: > "$(LOG)"; \
	error=0; \
	printf "\n$(GREEN)  Compiling $(NAME)...$(RESET)\n"; \
	if $(CC) $(CFLAGS) C/$(NAME).c -o C/$(NAME) >> "$(LOG)" 2>&1; then \
		printf "$(GREEN)  ✓ $(NAME).c compiled successfully$(RESET)\n"; \
	else \
		printf "$(RED)  ✗ $(NAME).c compilation failed$(RESET)\n"; \
		error=1; \
	fi; \
	if $(NASM) ASM/$(NAME).s -o ASM/$(NAME).o >> "$(LOG)" 2>&1 \
		&& ld ASM/$(NAME).o -o ASM/$(NAME) >> "$(LOG)" 2>&1; then \
		printf "$(GREEN)  ✓ $(NAME).s compiled successfully$(RESET)\n"; \
	else \
		printf "$(RED)  ✗ $(NAME).s compilation failed$(RESET)\n"; \
		error=1; \
	fi; \
	if [ "$$error" -ne 0 ]; then \
		printf "$(RED)  An error occurred during compilation.$(RESET)\n"; \
		cat "$(LOG)"; \
		exit 1; \
	fi; \
	$(MAKE) diff_maker NAME=$(NAME)

# ─────────────────────────────────────────────
# Diff Maker
# ─────────────────────────────────────────────

check_run:
	@cd $(DIR) || exit 1; \
	rm -f $(NAME)_diff Grace_kid.$(EXT); \
	if [ "$(NAME)" = "Grace" ]; then \
		if ! ./$(NAME) 2>> "$(LOG)"; then \
			printf "$(RED)  ✗ $(DIR)/$(NAME) exited with an error.$(RESET)\n" >&2; \
			exit 1; \
		fi; \
		result=Grace_kid.$(EXT); \
	else \
		if ! ./$(NAME) > $(NAME)_diff 2>> "$(LOG)"; then \
			printf "$(RED)  ✗ $(DIR)/$(NAME) exited with an error.$(RESET)\n" >&2; \
			exit 1; \
		fi; \
		result=$(NAME)_diff; \
	fi; \
	if ! diff $(NAME).$(EXT) "$$result" >> "$(LOG)" 2>&1; then \
		printf "$(RED)  ✗ $(DIR)/$(NAME): output differs from $(NAME).$(EXT). See $(LOG)$(RESET)\n" >&2; \
		exit 1; \
	fi; \
	printf "$(GREEN)  ✓ $(DIR)/$(NAME) OK$(RESET)\n"

diff_maker:
	@printf "\n$(GREEN)  Executing $(NAME)...$(RESET)\n"
	@if [ "$(NAME)" = "Sully" ]; then \
		(cd C && ./$(NAME)) >> "$(LOG)" 2>&1; \
		$(call wait_for,C/$(NAME)_0.c); \
		for i in 0 1 2 3 4; do \
			printf "\n== $(NAME)_$$i.c ==\n" >> "$(LOG)"; \
			diff C/$(NAME).c C/$(NAME)_$$i.c >> "$(LOG)" 2>&1; \
		done; \
		(cd ASM && ./$(NAME)) >> "$(LOG)" 2>&1; \
		$(call wait_for,ASM/$(NAME)_0.s); \
		for i in 0 1 2 3 4; do \
			printf "\n== $(NAME)_$$i.s ==\n" >> "$(LOG)"; \
			diff ASM/$(NAME).s ASM/$(NAME)_$$i.s >> "$(LOG)" 2>&1; \
		done; \
		printf "$(CYAN)  Sully cannot be verified automatically.$(RESET)\n"; \
		printf "$(CYAN)  Check logs/Sully.log and refer to the subject.$(RESET)\n"; \
	else \
		error=0; \
		$(MAKE) check_run DIR=C EXT=c NAME=$(NAME) || error=1; \
		$(MAKE) check_run DIR=ASM EXT=s NAME=$(NAME) || error=1; \
		if [ "$$error" -eq 0 ]; then \
			printf "$(GREEN)  ✓ $(NAME) successfully self-replicated.$(RESET)\n"; \
		else \
			exit 1; \
		fi; \
	fi
