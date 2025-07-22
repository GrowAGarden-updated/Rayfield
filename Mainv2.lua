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
            /* Using a slightly more visually interesting placeholder that still fits the "game" theme */
            background-image: url('https://placehold.co/1920x1080/2c3e50/ecf0f1?text=Game+Background');
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
            const originalText = "Copy KRNL Link";
            const copiedText = "Copied!";
            const failedText = "Failed to copy!";

            // Create a temporary textarea element
            const tempInput = document.createElement('textarea');
            tempInput.value = linkToCopy;
            // Make it invisible and off-screen
            tempInput.style.position = 'absolute';
            tempInput.style.left = '-9999px';
            tempInput.style.top = '-9999px';
            document.body.appendChild(tempInput);

            try {
                tempInput.select(); // Select the text
                const success = document.execCommand('copy'); // Execute copy command

                if (success) {
                    button.textContent = copiedText;
                } else {
                    button.textContent = failedText;
                    console.error('Failed to copy text using execCommand.');
                }
            } catch (err) {
                button.textContent = failedText;
                console.error('Error copying text:', err);
            } finally {
                document.body.removeChild(tempInput); // Clean up the temporary element

                // Revert button text after a delay
                setTimeout(() => {
                    button.textContent = originalText;
                }, 1500); // Increased delay slightly for better visibility
            }
        });
    </script>
</body>
</html>
