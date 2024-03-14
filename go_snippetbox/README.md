# A Flutter/Golang-based implementation of the Snippetbox application

Taken from the project app in "Let's Go!" by Alex Edwards.

All mistakes are (almost certainly) my own.

I'm an embedded developer by trade; cut me some slack!

### Project Structure

- `cmd`: contains application-specific code for executable apps. 
- `pkg`: contains ancillary non-application-specific code. mostly reusable 
code like validation helpers and some SQL database models.
- `ui`: user-interface assets like HTML templates, CSS, and images.


All the Go-specific stuff will live in the `cmd` and `pkg` directories.
