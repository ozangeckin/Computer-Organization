//AUTHOR:
//Ozan GECKIN
//1801042103
#include<iostream>
using namespace std;
#define MAX_SIZE 100 // Maximum size definition of array
int CheckSumPossibility(int num, int arr[], int size);//define recursive function
int j=1;//use array filling
int main()
{
    int arraySize;
    int arr[MAX_SIZE];
    int num;
    int returnVal;
    cout << "Please Enter Array Size: ";
    cin >> arraySize;
    cout <<"Please Enter Target Sum Number: ";
    cin >> num;

   
    for(int i = 0; i < arraySize; ++i)
 	{
 	 	cout <<"Please Enter array element "<< j << ": ";
 	 	cin >> arr[i];
 	 	j++;
 	}

 	returnVal = CheckSumPossibility(num, arr, arraySize);

 	if(returnVal == 1)
 	{
 		cout << "Possible!" << endl;
 	}	
 	else
 	{
 		cout << "Not possible!" << endl;
 	}
 return 0;
}
//Function Name: CheckSumPossibility
//Input Argument: int target number,int array,int array size
//Output: return int 1 or 0
//Description :Recursive function There are 2 base cases, one is the target number and the other is your array checking you.
//			   My other control is checking the target number with the last element of the array. If the target number is less than
//			   the last element of the array, I remove the last element and call the function again. If the last element is not less
//			   than the target number. I call recursive function twice. In one I am sending the last element the the recursive fuction.
//			   In the other, I remove the last element from the target number and send the target number that I just created and a decrease
//			   to you. Then I compare these two recursive results with the or logic operator and return.
int CheckSumPossibility(int num, int arr[], int size){
    if(num == 0){ //base case check target number
        return 1;
    }
    if(num<0 || size<=0){//base case2 check target number and size
        return 0;
    }
    if(arr[size-1] > num){
        return CheckSumPossibility(num, arr, size-1);
    }else{
        return CheckSumPossibility(num, arr, size-1)||CheckSumPossibility(num-arr[size-1], arr,size-1);
    }
}