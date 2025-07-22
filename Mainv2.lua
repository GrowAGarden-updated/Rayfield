<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delta Executor Detection</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            overflow: hidden; /* Prevent scrolling */
        }
        .background-image {
            background-image: url('https://placehold.co/1920x1080/000000/FFFFFF?text=Blurred+Background'); /* Placeholder image */
            background-size: cover;
            background-position: center;
            filter: blur(8px); /* Apply blur effect */
            -webkit-filter: blur(8px); /* For Safari */
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1; /* Ensure it's behind the modal */
        }
    </style>
</head>
<body class="bg-gray-900 flex items-center justify-center h-screen">
    <!-- Blurred Background Effect -->
    <div class="background-image"></div>

    <!-- Main Modal Frame -->
    <div class="relative bg-white p-6 rounded-lg shadow-xl max-w-sm w-full mx-4 sm:mx-0">
        <!-- Close Button (X icon) -->
        <button class="absolute top-3 right-3 text-gray-500 hover:text-gray-700 text-2xl font-bold">
            &times;
        </button>

        <!-- Title Section -->
        <div class="flex items-center justify-center mb-4">
            <h2 class="text-xl font-semibold text-gray-800">Error Message</h2>
        </div>

        <!-- Message Content -->
        <div class="text-center mb-6">
            <p class="text-sm text-gray-700 mb-2">
                Delta Executor detected.
            </p>
            <p class="text-xs text-gray-600 mb-4">
                If you're seeing this message, it means your executor blocked this script because the executor doesn't support the script.
            </p>
            <p class="text-sm text-gray-700 font-medium mb-1">To fix this:</p>
            <ul class="list-disc list-inside text-xs text-gray-600 space-y-1">
                <li>Put your Anti-Scam setting off in Delta</li>
                <li>Or use a compatible executor like KRNL instead!</li>
            </ul>
            <p class="text-xs text-gray-600 mt-4">
                NatHub recommends KRNL for best results.
            </p>
        </div>

        <!-- Copy KRNL Link Button -->
        <div class="flex justify-center">
            <button id="copyButton" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-6 rounded-md transition duration-300 ease-in-out shadow-md">
                Copy KRNL Link
            </button>
        </div>
    </div>

    <script>
        document.getElementById('copyButton').addEventListener('click', function() {
            const linkToCopy = "https://wearedevs.net/d/Krnl";
            const button = this;

            // Use a temporary textarea to copy text to clipboard
            const tempInput = document.createElement('textarea');
            tempInput.value = linkToCopy;
            document.body.appendChild(tempInput);
            tempInput.select();
            document.execCommand('copy');
            document.body.removeChild(tempInput);

            // Change button text to "Copied!" and revert after a delay
            button.textContent = "Copied!";
            setTimeout(() => {
                button.textContent = "Copy KRNL Link";
            }, 1000);
        });
    </script>
</body>
</html>
