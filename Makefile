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
		1) $(MAKE) Collenn;; \
		2) $(MAKE) Grace;; \
		3) $(MAKE) Sully;; \
		*) \
			printf "\n$(RED)  ✗ Invalid selection.$(RESET)\n"; \
			;; \
	esac


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
	@printf "$(WHITE)$(MAGENTA)  │$(RESET)\n"
	@printf "$(WHITE)$(MAGENTA)  └──────────────────────┘$(RESET)\n"


# ─────────────────────────────────────────────
# Programs
# ─────────────────────────────────────────────

Collenn:
	@printf "\n$(GREEN)  ✓ Testing Collenn...$(RESET)\n"
	# do Stuff

Grace:
	@printf "\n$(GREEN)  ✓ Testing Grace...$(RESET)\n"
	# do Stuff

Sully:
	@printf "\n$(GREEN)  ✓ Testing Sully...$(RESET)\n"
	# do Stuff
