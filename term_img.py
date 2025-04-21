from PIL import Image
import numpy as np

def print_img(pil_image, width=80):
    def rgb_to_ansi(r, g, b):
        """Convert RGB values to ANSI escape code for true color"""
        return f"\033[38;2;{int(r)};{int(g)};{int(b)}m"

    """
    Display a colored ASCII version of an image in the terminal.
    
    Args:
        image_path (str): Path to the image file
        width (int): Desired width of the output in characters
    """
    # ASCII characters from dense to sparse (for better visibility with colors)
    ascii_chars = "█▓▒░. "
    
    # Open image and convert to RGB mode
    img = pil_image.convert('RGB')
    
    # Calculate new dimensions while maintaining aspect ratio
    w_original, h_original = img.size
    height = int(width * h_original / w_original / 2)  # Divide by 2 because terminal chars are taller than wide
    
    # Resize image
    img = img.resize((width, height), Image.Resampling.LANCZOS)
    
    # Convert image to RGB array
    pixels = np.array(img)
    
    # Convert pixel values to colored ASCII characters
    ascii_img = ''
    for y in range(height):
        for x in range(width):
            r, g, b = pixels[y, x]
            
            # Calculate brightness for ASCII character selection
            brightness = (int(r) + int(g) + int(b)) / 3
            char_index = int(brightness * (len(ascii_chars) - 1) / 255)
            
            # Add colored character to string
            ascii_img += f"{rgb_to_ansi(r, g, b)}{ascii_chars[char_index]}"
            
        ascii_img += "\033[0m\n"  # Reset color at end of line
    
    print(ascii_img)

