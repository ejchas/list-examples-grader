CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

cp student-submission/*.java grading-area
cp *.java grading-area
cp -r lib grading-area

cd grading-area

javac -cp $CPATH *.java

if ! [ -f ListExamples.java ]
then 
    echo "Missing ListExamples.java in student submission"
    echo "Score: 0"
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt

if [ $? -ne 0 ] 
then
    echo "Compilation Error"
    echo "Score: 0"
    exit
else 
# Successful submission, calculate grade
    echo "Submission successful!" 
    lastline=$(grep -rc grading-area/test-output.txt | tail -n 2 | head -n 1)
    tests=$(echo $lastline | awk -F'[, ]' '{print $3}')
    failure=$(echo $lastline | awk -F'[, ]' '{print $7}')
    echo "Composite score: $tests/$failure"
    
fi

