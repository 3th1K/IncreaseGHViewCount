using OpenQA.Selenium.Chrome;

Console.Write("Enter the Username: ");
string? username = Console.ReadLine();

Console.Write("Enter the count (Leave blank for unlimited): ");
string? countInput = Console.ReadLine();

if (string.IsNullOrEmpty(username))
{
    Console.WriteLine("Username is null or empty");
    return;
}

var options = new ChromeOptions();
using var driver = new ChromeDriver(ChromeDriverService.CreateDefaultService(), options);

string url = $"https://github.com/{username}";

if (string.IsNullOrEmpty(countInput))
{
    int i = 1;
    while (true)
    {
        // Navigate to the URL
        driver.Navigate().GoToUrl(url);

        // Wait for a short period
        Thread.Sleep(1000); // 1-second delay
        Console.Write($"\rIncreased view count: {i++}");
    }
}
else if (int.TryParse(countInput, out int count))
{
    for (int i = 1; i <= count; i++)
    {
        // Navigate to the URL
        driver.Navigate().GoToUrl(url);

        // Wait for a short period
        Thread.Sleep(1000); // 1-second delay
        Console.Write($"\rIncreased view count: {i}/{count}");
    }
}
else
{
    Console.WriteLine("Invalid count. Please enter a valid number.");
}