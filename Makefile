.PHONY: all header welcome Collenn Grace Sully

MAKEFLAGS += --no-print-directory


# ─────────────────────────────────────────────
# Colors
# ─────────────────────────────────────────────

RESET  = \033[0m
WHITE  = \033[0;97m
GREY   = \033[0;90m
MAGENTA = \033[0;95m
PURPLE = \033[0;35m
GREEN  = \033[0;92m
RED    = \033[0;91m
CYAN   = \033[0;96m


# ─────────────────────────────────────────────
# Main
# ─────────────────────────────────────────────

all:
	@$(MAKE) header
	@$(MAKE) welcome
	@printf "\n"
	@printf "$(WHITE)$(PURPLE)  ➜  $(WHITE)Selection of the program to be tested : $(RESET)"
	@read programs; \
	case $$programs in \
		1) $(MAKE) program_compilation NAME=Collenn;; \
		2) $(MAKE) program_compilation NAME=Grace;; \
		3) $(MAKE) program_compilation NAME=Sully;; \
		*) \
			printf "\n$(RED)  ✗ Invalid selection.$(RESET)\n"; \
			;; \
	esac

clean:
	@rm ASM/*.o
	@rm C/*.o
	@rm */a.out

fclean: clean
	@rm ASM/Sully_*.s
	@rm ASM/Sully_*.c
	@rm */Collenn */Grace */Sully

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
	@printf "$(WHITE)$(MAGENTA)  ┌─ Available programs ─┐$(RESET)\n"
	@printf "$(WHITE)$(MAGENTA)  │$(RESET)\n"
	@printf "$(WHITE)$(MAGENTA)  │$(RESET)  $(GREEN)1.$(RESET) $(WHITE)Collenn$(RESET)\n"
	@printf "$(WHITE)$(MAGENTA)  │$(RESET)  $(GREEN)2.$(RESET) $(WHITE)Grace$(RESET)\n"
	@printf "$(WHITE)$(MAGENTA)  │$(RESET)  $(GREEN)3.$(RESET) $(WHITE)Sully$(RESET)\n"
	@printf "$(WHINL-LC1-42TE)$(MAGENTA)  │$(RESET)\n"
	@printf "$(WHITE)$(MAGENTA)  └──────────────────────┘$(RESET)\n"


# ─────────────────────────────────────────────
# Compilation
# ─────────────────────────────────────────────

program_compilation:
	@mkdir -p logs; \
	ERROR_CMP=0; \
	printf "\n$(GREEN)  Compile $(NAME)...$(RESET)\n"; \
	if clang -Wall -Werror -Wextra C/$(NAME).c -o C/$(NAME) >> logs/$(NAME).log 2>&1; then \
		printf "$(GREEN)  ✓ $(NAME).c compilation successful$(RESET)\n"; \
	else \
		printf "$(RED)  ✗ Failed $(NAME).c compilation$(RESET)\n"; \
		ERROR_CMP=1; \
	fi
	@if nasm -f elf64 ASM/$(NAME).s -o ASM/$(NAME).o >> logs/$(NAME).log 2>&1 && \
	   ld ASM/$(NAME).o -o ASM/$(NAME) >> logs/$(NAME).log 2>&1; then \
		printf "$(GREEN)  ✓ $(NAME).s compilation successful$(RESET)\n"; \
	else \
		printf "$(RED)  ✗ Failed $(NAME).s compilation$(RESET)\n"; \
		ERROR_CMP=1; \
	fi; \
	if [ "$$ERROR_CMP" -eq 1 ]; then \
		printf "$(RED)  An error was encountered during compilation.$(RESET)\n"; \
		cat logs/$(NAME).log; \
	fi; \
	rm -f logs/$(NAME).log; \
	exit "$$ERROR_CMP"


# ─────────────────────────────────────────────
# Test
# ─────────────────────────────────────────────

program_test:

