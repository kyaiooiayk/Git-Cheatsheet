# GIT Cheatsheet
*List of commands & case studies you may find yourselF dealing with.* 
***

# Table of content
- [Git, GitHub and GitLab](#git-github-and-gitlab)
- [How to install Git](#how-to-install-git)
- [How to change your email and username](#how-to-change-your-email-and-username)
- [How to change the `AUTHOR/COMMITTER_NAME` for all your previous commits](#how-to-change-the-authorcommitter_name-for-all-your-previous-commits)
- [How to delete your commits history?](#how-to-delete-your-commits-history)
- [How to write your commit texts](#how-to-write-your-commit-texts)
- [How to unstage/delete changes made locally](#how-to-unstagedelete-changes-made-locally)
- [Cloning the project](#cloning-the-project)
- [Clone, venv and requirements.txt installation](#clone-venv-and-requirementstxt-installation)
- [How to check the commits history](#how-to-check-the-commits-history)
- [Branch](#branch)
- [`main` vs. `master`](#main-vs-master)
- [Getting the current status](#getting-the-current-status)
- [Adding changes](#adding-changes)
- [Commit changes](#commit-changes)
- [Undo commits](#undo-commits)
- [Ignoring some files: `.gitignore`](#ignoring-some-files-gitignore)
- [`.gitignores` vs. `.gitattributes`](#gitattributes-vs-gitignore)
- [Push to the server](#push-to-the-server)
- [How to force push](#how-to-force-push)
- [Pulling from server](#pulling-from-server)
- [git pull vs. git fetch](#git-pull-vs-git-fetch)
- [Dealing with errors](#dealing-with-errors)
- [Password no longer accepted](#getting-your-token-password-no-longer-accepted)
- [Saving your tokeen on your Mac](#saving-token-on-your-mac)
- [How to push large files](#large-files)
- [How to delete the cache from another git repository](#how-to-delete-the-cache-from-another-git-repository)
- [CI/CD with GitHub Actions](#cicd-with-github-actions)
- [Tagging](#tagging)
- [How to add SSH key](#how-to-add-ssh-key)
- [Git hooks](#git-hooks)
- [Git flow vs. GitHub flow](#git-flow-vs-github-flow)
- [Git head and base](#git-head-and-base)
- [Git merge vs. rebase](#git-merge-vs-rebase)
- [GitHub CLI](#github-cli)
- [Deploy documentation on GitHub pages](#deploy-your-doc-with-github-pages)
- [remote vs. origin](#remote-vs-origin)
- [ssh-vs-http protocols](#ssh-vs-http-protocols)
***

## Git, GitHub and GitLab
- **GIT** stands for Global Information Tracker. - GitHub and GitLab are remote server repositories based on GIT.
- GitHub is a collaboration platform that helps review and manage codes remotely.
- GitLab is the same but is majorly focused on DevOps and CI/CD. 
***

## How to install `git`
- If you have a conda virtual environment: `conda install git`
- On MacOS, if you are getting this error `xcrun: error: invalid active developer path`, see the discussion [here](https://apple.stackexchange.com/questions/254380/why-am-i-getting-an-invalid-active-developer-path-when-attempting-to-use-git-a).
***

## How to change your email and username
- Your name and email address are configured automatically based on your username and hostname. If this is not done you can always overwrite it with:
```
git config --global user.name <your_name>
git config --global user.email <your_email_address>
```
- To change this defaul option, run the following command and follow the instructions in your editor to edit your configuration file: `git config --global --edit`
- After doing this, you may fix the identity used for this commit with: `git commit --amend --reset-author`
***

## How to change the `AUTHOR/COMMITTER_NAME` for all your previous commits
- There are cases where youstart working on your another PC, you push the commits and you then realise you fortgot to update your credentials. If do this what is shown in the remote server is not what you generally see but what git used as a default. This [answer](https://stackoverflow.com/questions/4493936/could-i-change-my-name-and-surname-in-all-previous-commits) on stackoverflow how to ammend this: 
- Suppose you want to change the `GIT_AUTHOR_NAME` then run this (`-f` is the forced option):
```
git filter-branch --commit-filter \
'if [ "$GIT_AUTHOR_NAME" = "your_old_author_name" ]; then \
export GIT_AUTHOR_NAME="your_new_name";\
export GIT_AUTHOR_EMAIL=your_email_addressi@gmail.com;\
export GIT_COMMITTER_NAME="your_new_name";\
export GIT_COMMITTER_EMAIL=your_new_name@gmail.com;\
fi;\
git commit-tree "$@"' -f
```
- Alternative you can also try this (contrary to the one above there is no if statement it will update everything with no distinction):
```
git filter-branch --commit-filter 'export GIT_COMMITTER_NAME="your_new_commiter_name"; \
export GIT_AUTHOR_EMAIL=your_email_address@gmail.com; git commit-tree "$@"'
```
- Once this is done you want to update the remote server: `git push --all origin --force`
***

## How to delete your commits history?
- Say you have some sensitive information on your commits history and you'd like to remove them all.
- One option would be to delete the `.git` folder but this may cause problems in your git repository. If you want to delete all your commit history but keep the code in its current state, it is very safe to do it as in the [following](https://stackoverflow.com/questions/13716658/how-to-delete-all-commit-history-in-github).
 - Find our which branch you are on (generally either `main` or `master`): `git rev-parse --abbrev-ref HEAD`. Then change the code below accordingly on the branch you are on.
 - Checkout: `git checkout --orphan latest_branch`
 - Add all the files (move it the stage area): `git add -A`
 - (Alternative you can move a single/folder file): `git add <path_to_specific_file_or_folder>`
 - Commit the changes: `git commit -am "commit message"`
 - Delete the branch: `git branch -D main`
 - Rename the current branch to main: `git branch -m main`
 - Finally, force update your repository: `git push -f origin main`
***

## How to write your commit texts
- [Use templates for better Git commit messages: a casa stade from Autotrader](https://engineering.autotrader.co.uk/2018/06/11/use-templates-for-better-commit-messages.html)
- [Here](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) is the template written by Tim Pope:

```
Capitalized, short (50 chars or less) summary

More detailed explanatory text, if necessary.  Wrap it to about 72
characters or so.  In some contexts, the first line is treated as the
subject of an email and the rest of the text as the body.  The blank
line separating the summary from the body is critical (unless you omit
the body entirely); tools like rebase can get confused if you run the
two together.

Write your commit message in the imperative: “Fix bug” and not “Fixed bug”
or “Fixes bug.”  This convention matches up with commit messages generated
by commands like git merge and git revert.

Further paragraphs come after blank lines.

- Bullet points are okay, too

- Typically a hyphen or asterisk is used for the bullet, followed by a
  single space, with blank lines in between, but conventions vary here

- Use a hanging indent
```
***

## How to unstage/delete changes made locally
- Before we make a commit, we must tell Git what files we want to commit (new untracked files, modified files, or deleted files). This is called staging and uses the add command. 
- To unstage a file that has been staged but keep the modifications in the working directory:  `git restore --staged <your_file_path>`
- Alternatively, you can simply delete any modification and restore the previous commit: `git restore <your_file_path>` Restore can be dangerous: anything committed in Git can be recovered in one way or another, but restoring a file will delete the modifications forever.
- How to remove the staged files but keep the files: `git rm -r --cached <name of the file to be removed>`
***

## Cloning the project
- This is the case where the repository is created first on GitHub. 
```
# Clone with HTTPS
git clone https://gitlab.com/*******
# Clone with SSH
git clone git@gitlab.com:*******
```
***

## Clone, venv and requirements.txt installation
- This is how to start using a git project:
```
$ git clone https://github.com/username/project_name.git
$ cd project_name
$ virtualenv -p python3 my_venv_name
$ source my_venv_name/bin/activate
$(my_venv_name) pip install -r requirements.txt
```
***

## How to check the commits history
- `git log`
- `git log -3`: get the last 3 commit messages
- `git log --oneline`: shorthand for --pretty=oneline --abbrev-commit used together.
- `git log --graph`: display an ASCII graph of the branch and merge history beside the log output.
***

## Branch
- Creating a branch is useful because it allows us to freely experiment (generally keep a different model of the code) withouth touching the original code. At a later stage, you can always merged what you have done in the branch version into the main one.
- Once you clone the project to your local machine, you only have the **main branch**. 
- You should make all the changes on a new branch that can be created using the git **branch command**. 
- Your branch is the copy of the master branch/main. 
- Creating a new branch does not mean that you are working on the new branch. You need to **switch to that branch**.
- WARNING! `git switch` is very similar to `git checkout` to the point that they do effectively the same thing. See this discussion [here](https://stackoverflow.com/questions/57265785/whats-the-difference-between-git-switch-and-git-checkout-branch).
  - Create a branch: `git branch mybranch`
  - Switch to a new branch: `git switch mybranch`
  - To push into this branch you need to set the upstream branch with: `git push --set-upstream origin <name_of_new_branch>`. [Why do we need seto an upstream branch](https://stackoverflow.com/questions/37770467/why-do-i-have-to-git-push-set-upstream-origin-branch)
  - Show all the local branches of your repo. The starred branch is your current branch: `git branch` or `git branch --show-current`
  - Show all the remote branches: `git branch -r`
  - Show all the remote branches with latest commit: `git branch -rv`
  - Show all remote and local branches with: `git branch -a`
  - Show all new remote banches: first `git fetch`, then see if they are visibile `git branch -r`, ultimately `git checkout -t origin/new_remote_branch`, where the flag `t` stands for track.
  - If you want to delete your new branch locally: `git branch --delete <branchname>`. It should be noted that when you delete a local Git branch, the corresponding remote branch in a repository like GitHub or GitLab remains alive and active. Further steps must be taken to delete remote branches.
  ***

## `main` vs. `master`
- The computer industry's use of the terms master and slave was considered no longer appropriate after the eventis that took place in the summer of 2020. 
- Amid the many protests and the growing social unrest, these harmful and antiquated terms were no longer considered appropriate.
- The option is not a default one, GitHub encourage this but does not ban the use.
***

## Getting the current status
- To know what branch you are workign on 
- To show what changes (if any) have been staged: ```git status```
***

## Adding changes
 - This stepp is different from the **commit** phase. 
 - When you make changes in the code, the branch you work on becomes different from the master branch. These changes are not visible in the master branch unless you take a series of actions.
 - The first action is the git add command. This command adds the changes to what is called the **staging area**. 
 
![image](https://user-images.githubusercontent.com/89139139/147848375-842d8495-06ce-485e-96c6-5efa8b5f35b5.png)

```
# Adding everything in the current directoru
git add .
# Adding a specific file
git add <name of your specific file>
# Add manually a folder which is NOT shown in the list of commitments
git add —all <name of your folder>
```
***

## Commit changes
- It is not enough to add your updated files or scripts to the staging area. You also need to “commit” these changes using the git commit command.
- The important part of the git commit command is the message part. It briefly explains what has been changed or the purpose of this change. 
- There is not a strict set of rules to write commit messages. 

```
# Commit plus add a message
git commit -m <add here your message>
# Alternativaly you can use this, which will bring you to current status
# of what changes, you can add a message (via vim for instance) there and save the file
git commit -a
```
***

## Undo commits
- `git revert <commit>` Git revert undoes the changes back to a specific commit and adds it as a new commit, keeping the log intact. To revert, you need to provide a hash of a specific commit. 
- `git reset <commit>` You can also undo changes by using the reset command. It reset the changes back to a specific commit, discarding all commits made after. Note: Using reset command is **discouraged** as it modifies your git log history. 
***

## Ignoring some files: `.gitignore`
- There may be situations where: 
 - You do not want to share a specific files because of confidentiality reason
 - The file is too big and Git-based remote server are not meant for this.
 - There are a lot not useful files such as `.pyc` and `.so`. 
 - Create a hidden file named: .gitignore where the “.” is important: `vim .gitignore`
 - Tell Git where the `.gitingore` file is and how to add files: `git config --global core.excludesfile '~/.gitignore'`
 - Add a new file type to gitignore: `echo '.ipynb_checkpoints' >> .gitignore`
- This is an example:
```shell
# Some of my current configuration of .gitignore
*.ipynb_checkpoints
*.pyc
*.pyo
__pycache__/
```
***

## `.gitattributes` vs. `.gitignore`
- `.gitignore` ignores untracked files, those that haven't been added with git add. Essentially it tells git that by default it shouldn't pay attention to untracked files at a given path.
- `.gitattributes` are for tracked files.
- Thais situation is usueful when we want to ignore all PDF fiel but one. That one will be processed with `.gitattributes` and two other could be ignored asper the `.gitignore`.
- If you put *.pdf in .gitignore, and also use .gitattributes to set up *.pdf with the attributes for LFS tracking, then:
  - By default, an untracked PDF file will be ignored by git.
  - To add a new PDF file to the index, you would override the ignore rule with `git add -f`
  - Once a PDF file exists at a specific path, that path is no longer governed by the ignore rule
  - Any PDF file you do add will be managed by LFS per the .gitattributes
  - Any PDF file already in the repo (which would be unaffected by the ignore rule) should be managed by LFS, though if it was committed before the .gitattributes entry it may not be.
***

## Push to the server
- Pushing your code will save your changes in a remote branch = **master branch**
- If you were not on a branch this will still work.
- After your branch is pushed, A **merge request** is asking the maintainer of the project to “merge” your code to the master branch. The maintainer will first review your code. If the changes are OK, your code will be merged. 
```
# This will push the changes to the server
git push
# If you are not working in a branch
git push origin master
```
- Suppose the file you want to update in git but you made some small changes **locally** that you do **NOT** want to keep anymore. 
- If you use `git pull` it will throw you an error saying: `Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded'. 
```
# Discard local changes to all files, permanently
git reset –hard
# Then you can use “git pull” to update your local directory
git pull
```
***

## Push to the server failed because of large file (even after deletion)
- You have to option here: squashing or filter-branch. The latter seems to better because it does not mess with the entire history. [Ref](https://stackoverflow.com/questions/19573031/cant-push-to-github-because-of-large-file-which-i-already-deleted)
    - Locally delete or modify (reduce) large files.
    - Commit the local deletes.
    - Soft reset back X number of commits: `git reset --soft HEAD~X`.
    - Then recommit all the changes together (AKA squash) `git commit -m "New message for the combined commit"`
    - Push squashed commit.
***

## How to force push
- If you get an error like this: `Git push failed, "Non-fast forward updates were rejected"`. Then you can use `git push --force` to force push your changes to the server. You need to push about what you are doing and this may not be ideal when working in large projects where others are involved. [Ref](https://stackoverflow.com/questions/6897600/git-push-failed-non-fast-forward-updates-were-rejected)
***

## Pulling from server
- While you are working on a task in your local branch, there might be some changes in the remote branch. The `git pull` command is used for making your local branch up to date. You should use the git pull command to update your local working directory with the latest files in the remote branch. 
- By default, the pull command fetches the changes and merges them with the current branch. To rebase, instead of merge, you can add the `--rebase` flag before the remote name and branch: `git pull --rebase origin master`
- Pulling a specific branch: `git pull origin <branch_name>`
***

## git pull vs. git fetch
- There are 3 importants locations in a git installtion:
    - The **working directory** is where a developer actively edits and updates files that Git tracks.
    - The **local Git repository** is where the history of all commits across all branches are maintained.
    - The **remote repository** is the place where your code is stored.
- The key difference between git fetch and pull is that git pull copies changes from a remote repository directly into your working directory, while git fetch does not. The git fetch command only copies changes into your local Git repo. The git pull command does both.

![image](https://github.com/kyaiooiayk/Git-Cheatsheet/assets/89139139/757ea6c8-fadb-4c03-a9ca-e3ecb9c0c0b8)
***

## Dealing with errors
- If it throws an error saying there is another process live. Try: zrm -f .git/index.lockz
- If `git push` hangs after Total, try to increase the maximum size of the buffer with as suggested [here](https://stackoverflow.com/questions/15843937/git-push-hangs-after-total-line): `git config --global http.postBuffer 157286400` then try to push again.
***

## Getting your token (password no longer accepted)
- From August 13, 2021, GitHub is no longer accepting account passwords when authenticating Git operations. You need to add a PAT (Personal Access Token) instead, and you can follow the below method to add a PAT on your system.
- From your GitHub account, go to Settings => Developer Settings => Personal Access Token => Generate New Token (Give your password) => Fillup the form => click Generate token => Copy the generated Token, it will be something like ghp_sFhFsSHhTzMDreGRLjmks4Tzuzgthdvfsrta
- Click on the Spotlight icon (magnifying glass) on the right side of the menu bar. Type Keychain access then press the Enter key to launch the app => In Keychain Access, search for github.com => Find the internet password entry for github.com => Edit or delete the entry accordingly => You are done. However, once you use this taken once, when you are prompted for the password this steo is not generally required.
***

## Saving token on your Mac
- Unset any previous credentia storage you are using with: `git config --global --unset credential.helper`
- Tell tell Git you want to store credentials in the osxkeychain by running the following: `git config --global credential.helper osxkeychain`
- You can remove an existing password or token stored in the osxkeychain using the following command: `git credential-osxkeychain erase`
- See this [refence](https://gist.github.com/jonjack/bf295d4170edeb00e96fb158f9b1ba3c) for more.
***

## Large files
- GitHub limits the size of files allowed in repositories. To track files beyond this limit, you can use Git Large File Storage.
- In order to use Git LFS, you'll need to download and install a new program that's **separate** from Git.
- You can read more about it [here](https://docs.github.com/en/repositories/working-with-files/managing-large-files)
***

## How to delete the cache from another git repository
- Suppose you have clone a folder inside one of your git repository. If you try to push git will throw you this error message `You've added another git repository inside your current repository.` You now have two options:
   - Option #1: navigate to the clones repositoy and delete all the hidden files that start wiht `.git` 
   - Option #2: `git rm --cached <path_of_clone_folder>`
***

## CI/CD with GitHub Actions
- [How to build a CI/CD pipeline with GitHub Actions in four simple steps](https://github.blog/2022-02-02-build-ci-cd-pipeline-github-actions-four-steps/)
- [How to Build MLOps Pipelines with GitHub Actions [Step by Step Guide]](https://neptune.ai/blog/build-mlops-pipelines-with-github-actions-guide)
***

## Tagging
- Listing the existing tags in Git is straightforward: `git tag`
- Listing the existing tags with a particular patter: `git tag -l "v1.8.5*"`
- Create a tag along with a commit message: `git tag -a v1.4 -m "my version 1.4"`
- See more [here](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
***

## How to add SSH key
- [How to Add SSH Keys to Your GitHub Account](https://www.inmotionhosting.com/support/server/ssh/how-to-add-ssh-keys-to-your-github-account/)
***

## Git Hooks
- Git Hooks are a built-in feature used to automate tasks/enforce policies.
- `Pre-push` hooks can be used to prevent pushes to certain branches or run additional tests before pushing. `Post-merge` hooks can be used to perform actions after a merge is completed, such as updating dependencies or generating documentation. These hook scripts are only limited by a developer's imagination.
- Create directory with `mkdir .git/hooks`. The scripts should be named after the Git Hook event they correspond to (e.g., pre-commit, pre-push, post-merge) and have the appropriate permissions `chmod +x`. Git will automatically execute them at the corresponding events. 

## Installing `pre-commit`
- The idea is to check all my staged files (`git add file_to_stage`). One of the most common check is formatting and compliance against PEP8. The former is done by `black` while the latter is done by `flake8`. If everything passes, the commit is made. If not, then you are requiered to manually ammend the code. Pre-commit are a kind of git hooks.

<img width="613" alt="image" src="https://github.com/kyaiooiayk/Git-Cheatsheet/assets/89139139/380b79c9-abf0-47da-a86a-e500dd9f0b13">
 
- Install pre-commit with: `pip install pre-commit` and check installation with: `pre-commit --version`
- Add pre-commit to `requirements.txt` (or `requirements-dev.txt` if you have one)
- Create a file named `.pre-commit-config.yaml` and fill it with actions you'd  like to perform. [Template](https://github.com/kyaiooiayk/Git-Cheatsheet/blob/main/repository/.pre-commit-config.yaml)
- Configure `black` inside the file `pyproject.toml`. [Template](https://github.com/kyaiooiayk/Git-Cheatsheet/blob/main/repository/pyproject.toml)
- Configure `Flake8` so it works nicely with `black` in the `.flake8` configuration file. [Template]()
- Run `pre-commit install` to set up the git hook scripts
- Now `pre-commit` will run automatically on `git commit`
- If you wish to run before manually before commit: `pre-commit run -a` or equivalently: `pre-commit run --all-files` if this is an existing project.
***

## Git flow vs. GitHub flow
- `GitHub flow` is used when there are no releases for the application and there is regular deployment to production.
- `Git flow` is more complex than GitHub flow, and is used when the software/application has the concept of the release. When more than one developer is working on the same feature.
***

## Git head and base
- The **head** is the branch which you are on; that is, the branch with your changes. To show where the head is pointing to use: `git show` and you should be able to see something like this:
```shell
commit 541e622e233b664fe5eb2753bf647a9eb0ef678f (HEAD -> main, origin/main, origin/HEAD)
```
- The **base** is the branch off which these changes are based.
***

## Git merge vs. rebase
- **Merge** a commit that combines all changes of a different branch into the current.
- **Rebase** allows you to use another branch as the new base for your work. Re-comitting all commits of the current branch onto a different base commit. Rebase is a destructive operation. That means, if you do not apply it correctly, you could lose committed work and/or break the consistency of other developer's repositories.
- Reverting (as in undoing) a rebase is considerably difficult and/or impossible (if the rebase had conflicts) compared to reverting a merge. If you think there is a chance you will want to revert then use merge.
- Consider the case where you have two branches `main` and `feature1` where `main` is the base of `feature1`. To add this feature to your `main` branch: `git checkout main` and `git merge feature1`. But this way a new dummy commit is added. If you want to avoid spaghetti-history you can rebase: `git checkout feature1` and `git rebase main`; then you can: `git checkout main` and `git merge feature1`.
***

## GitHub CLI
- If on Mac install it with: `brew install gh`
- Save your token with: `gh auth login`
- Add your recent changes: `git add <name_of_changed_file>`
- Add a commit commend: `git commit -m "new_change"`
- Push: `git push`
- Create a pull request where by providing the base and branch: `gh pr create -B main -H <branch_name> -f`
- Merge request with autofil:  `gh pr merge --admin -m`
***

## Deploy your doc with GitHub pages
- Install `mkdocs` with: `pip install mkdocs`
- Create a folder called `docs` in your repository and place there all the `.md` files there.
- Create a `mkdocs.ymal` on your project root directory.
- Build doctumentation with: `mkdocs buil`
- Build doctumentation with: `mkdocs serve` and you can have a look at the locally deployed docs.
- When you are satisfied with it, you can then deploy it to Github pages with: `mkdocs gh-deploy`. This will create an additional branch called `gh-pages` and your docs should then be available.
***

## remote vs. origin
- When you clone a repository with git clone, it automatically creates a remote connection called origin pointing back to the cloned repository.
- This is useful for developers creating a local copy of a central repository, since it provides an easy way to pull upstream changes or publish local commits.
- This behavior is also why most Git-based projects call their central repository origin.
***

## SSH vs. HTTP protocols
- Git supports many ways to reference a remote repository. Two of the easiest ways to access a remote repo are:
 - via the HTTP protocol: allows easy way to allow anonymous, read-only access to a repository
 - via SSH protocols: allows easy way to allow anonymous, read-write access to a repository
***

## References
- https://www.kdnuggets.com/2021/10/8-git-commands-data-scientists.html 
- https://www.upgrad.com/blog/github-vs-gitlab-difference-between-github-and-gitlab/ - https://chryswoods.com/beginning_git/README.html
- [Official GitHub Docs](https://docs.github.com/en/github)
- [How to install Git on Windows](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Quick guide of what VC is and how to use GIT](https://docs.google.com/presentation/d/1_AYIcCyVI59QiiXqU4Sn7VzwtVyfqv-lG36EPFzeSdY/edit#slide=id.gc0ca3f56b2_0_12)
- [Use templates for better Git commit messages](https://engineering.autotrader.co.uk/2018/06/11/use-templates-for-better-commit-messages.html)
- [Git cheatsheet](https://www.kdnuggets.com/publications/sheets/Git_Cheatsheet_KDnuggets.pdf)
- [Why GitHub renamed its master branch to main](https://www.theserverside.com/feature/Why-GitHub-renamed-its-master-branch-to-main)
- [Oh Shit, Git!?!](https://ohshitgit.com/)
- [What are GitHooks](https://githooks.com/)
- [Git Flow vs. Github Flow](https://www.scaler.com/topics/git/git-flow-vs-github-flow/)
- [Automate Python workflow using pre-commits: black and flake8](https://ljvmiranda921.github.io/notebook/2018/06/21/precommits-using-black-and-flake8/)
- [gitignore vs. gitattributes](https://stackoverflow.com/questions/47219985/gitignore-vs-gitattributes)
- [About workflow](https://docs.github.com/en/actions/using-workflows/about-workflows)
- [When do you use git rebase  instead of git merge](https://stackoverflow.com/questions/804115/when-do-you-use-git-rebase-instead-of-git-merge)
- [Git pull vs fetch: What's the difference?](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/Git-pull-vs-fetch-Whats-the-difference)
- [GitHub official command line](https://cli.github.com/manual/)
- [Deploy your docs](https://www.mkdocs.org/user-guide/deploying-your-docs/)
- [git remote](https://www.atlassian.com/git/tutorials/syncing)
***
