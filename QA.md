Q: What roles can interact with the conversation history (e.g., admin, manager, contributor)?
A: Only project members. Admins and PMs can change status; everyone can comment.

Q: Who can see the project conversation history?
A: All users with access to the project.

Q:Should each status change be treated like a comment (i.e., timestamped, user-linked)?
A: Yes, status changes should appear like comments in the timeline.

Q:Should users be able to edit or delete their own comments or status changes?
A: Users can edit comments, not delete. Status changes are immutable.

Q: Which statuses should be allowed (e.g., Draft, In Progress, Completed, Archived)?
A: Draft, In Progress, Blocked, Completed.

Q: Should comments support Markdown or plain text only?
A: Plain text for now.

Q: Should comments support file attachments?
A: Not for the first version.

Q: Should there be notifications (email or in-app) for new comments or status changes?
A: In-app notification, email optional in later versions.

Q: Should the conversation history be on its own page or embedded in the project detail page?
A: Embedded on the project detail page, maybe in a tab.

Q: Do you want timestamps and user names shown for each comment or status change?
A:  Would be nice to have

Q: What design system should be followed (e.g., Tailwind, existing components)?
A: Use Tailwind and ViewComponent; follow existing styles.

Q: Is authentication and user access already implemented?
A: No, we need to build it. Lets use devise gem for ease of development.

Q: How are projects currently stored (e.g., existing Project model)?
A: Let create a dummy Project model with title, description, and status.

Q: Do we need API support for this feature ?
A: Not for this version.

Q: How do we know this feature is complete and successful?
A: Users can leave comments, change project status, and see a clear, chronological history of all these actions.
