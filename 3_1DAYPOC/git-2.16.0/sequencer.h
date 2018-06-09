#ifndef SEQUENCER_H
#define SEQUENCER_H

const char *git_path_seq_dir(void);

#define APPEND_SIGNOFF_DEDUP (1u << 0)

enum replay_action {
	REPLAY_REVERT,
	REPLAY_PICK,
	REPLAY_INTERACTIVE_REBASE
};

struct replay_opts {
	enum replay_action action;

	/* Boolean options */
	int edit;
	int record_origin;
	int no_commit;
	int signoff;
	int allow_ff;
	int allow_rerere_auto;
	int allow_empty;
	int allow_empty_message;
	int keep_redundant_commits;
	int verbose;

	int mainline;

	char *gpg_sign;

	/* Merge strategy */
	char *strategy;
	char **xopts;
	size_t xopts_nr, xopts_alloc;

	/* Only used by REPLAY_NONE */
	struct rev_info *revs;
};
#define REPLAY_OPTS_INIT { -1 }

int sequencer_pick_revisions(struct replay_opts *opts);
int sequencer_continue(struct replay_opts *opts);
int sequencer_rollback(struct replay_opts *opts);
int sequencer_remove_state(struct replay_opts *opts);

#define TODO_LIST_KEEP_EMPTY (1U << 0)
#define TODO_LIST_SHORTEN_IDS (1U << 1)
#define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
int sequencer_make_script(FILE *out, int argc, const char **argv,
			  unsigned flags);

int sequencer_add_exec_commands(const char *command);
int transform_todos(unsigned flags);
int check_todo_list(void);
int skip_unnecessary_picks(void);
int rearrange_squash(void);

extern const char sign_off_header[];

void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
void append_conflicts_hint(struct strbuf *msgbuf);

#endif
