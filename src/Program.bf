using System;
using System.Collections;

namespace GuessingGame;


class Program
{
	static bool isDigit(String input)
	{
		for (int i = 0; i < input.Length; i++)
		{
			if (!input[i].IsDigit)
			{
				return false;
			}	
		}

		return true;
	}

	static String GetInput(String prompt)
	{
		var inputBuffer = new String();
		Console.Write(prompt);

		Console.ReadLine(inputBuffer);
		inputBuffer.Trim();

		return inputBuffer;
	}

	static int ProcessInput()
	{
		bool isInputValid = false;
		int inputNumber = 0;

		while (!isInputValid)
		{
			String inputBuffer = GetInput("Guess the number between 1 - 10: ");
			defer delete inputBuffer;

			if (inputBuffer == "")
			{
				Console.WriteLine("Please enter a number between 1 - 10");
				continue;
			}

			if (!isDigit(inputBuffer))
			{
				Console.WriteLine("Input is not a number");
				continue;
			}

			Result<int, Int.ParseError> inputResult = int.Parse(inputBuffer);

			switch(inputResult)
			{
				case .Ok:
					inputNumber = inputResult.Get();

					if (inputNumber > 10 || inputNumber < 1)
					{
						Console.WriteLine("Input number should be between 1 - 10");
						break;
					}

					isInputValid = true;
					break;

				case .Err:
					Console.WriteLine("Failed at parsing input number");
					break;
			}

		}

		return inputNumber;
	}

	static int secretNumber = gRand.NextI32() % 9 + 1;
	static int attempt = 5;

	static void Reset()
	{
		secretNumber = gRand.NextI32() % 9 + 1;
		attempt = 5;
	}

	static void CheckAttempt()
	{
		attempt--;

		if (attempt == 0)
		{
			Console.WriteLine($"You lose the secret number is {secretNumber}");

			while (true)
			{
				String playAgainChoice = GetInput("Wanna play again? (y/n): ");
				defer delete playAgainChoice;

				if (playAgainChoice == "y")
				{
					Reset();
					break;
				}
				else if (playAgainChoice == "n")
				{
					Environment.Exit(0);
				}
				else
				{
					Console.WriteLine("Wrong Input it should be y or n");
				}
			}

			return;
		}

		Console.WriteLine($"You have {attempt} attempt left");
	}

	static void Main()
	{
		while (true)
		{
			int inputNumber = ProcessInput();

			if (inputNumber > secretNumber)
			{
				Console.WriteLine("Your guess is too big");
				CheckAttempt();
			}
			else if (inputNumber < secretNumber)
			{
				Console.WriteLine("Your guess is too small");
				CheckAttempt();
			}
			else
			{
				Console.WriteLine($"You win the secret number is {secretNumber}");

				while (true)
				{
					String playAgainChoice = GetInput("Wanna play again? (y/n): ");
					defer delete playAgainChoice;

					if (playAgainChoice == "y")
					{
						Reset();
						break;
					}
					else if (playAgainChoice == "n")
					{
						Environment.Exit(0);
					}
					else
					{
						Console.WriteLine("Wrong Input it should be y or n");
					}
				}
			}
		}
	}
}