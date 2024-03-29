if [ "$TRAVIS_BRANCH" != "dev" ]; then 
    exit 0;
fi
export GIT_COMMITTER_EMAIL="fredy.ballesteros@gmail.com"
export GIT_COMMITTER_NAME="Fredy Ballesteros"
rev=$(git rev-parse --short HEAD)
git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* || exit
git fetch --all || exit
git stash
git checkout master || exit
git merge --no-ff "$TRAVIS_COMMIT" || exit
git stash pop
git commit --amend -am "Rev: ${rev} - commit from Travis CI"
git push https://${GITHUB_TOKEN}@github.com/fredyballest/desplieguecontinuo.git
