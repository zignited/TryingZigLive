//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

// programming language name,version
// zig,0.14.1
//
// Jorge
// ​​Long story short, to use relative paths you need to pass the name through std.unicode.wtf8ToWtf16LeAlloc() to get a Windows string
// WindowsUTF-8 to WindowsUTF-16
pub fn main() !void {

    print("All your {s} are belong to us.\n", .{"codebase"});
    // print("CWD: {any}\n", .{std.fs.cwd()});
    // --- 1. Create a dummy file for the example ---
    // In a real program, you would skip this part.
    const file_path = "D:\\work\\Zignited\\code\\Trying Zig\\tz1_build\\src\\my_data.txt";
    const file_content_to_write = "Hello from Zig!\nThis is a multi-line string.";
    // try std.fs.cwd().writeFile(file_path, file_content_to_write);
    try std.fs.cwd().writeFile(.{
        // .path = file_path,
        // .data = file_content_to_write,
        .sub_path = file_path,
        .data = file_content_to_write,
        // flags: File.CreateFlags = .{},
    });


    // --- 2. Get an allocator ---
    // The heap page allocator is a good general-purpose choice.
    const allocator = std.heap.page_allocator;

    // --- 3. Read the entire file into a string (slice) ---
    // We must provide a reasonable size limit to avoid allocating too much memory.
    const max_file_size = 1024 * 2; // 1024 * 1024 1 MB limit
    const file_string = try std.fs.cwd().readFileAlloc(allocator, file_path, max_file_size);

    // IMPORTANT: Since we allocated memory, we must free it when we're done.
    // 'defer' ensures this runs at the end of the function, even if errors occur later.
    defer allocator.free(file_string);

    // --- 4. Use the string ---
    // The result is a []u8 slice, which is how Zig handles strings.
    // We can print it using the {s} format specifier.
    std.debug.print("Successfully read file into string:\n---\n{s}\n---\n", .{file_string});
    std.debug.print("The type of the result is: {}\n", .{@TypeOf(file_string)});

}
const std = @import("std");
const print = @import("std").debug.print;

/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
 const lib = @import("tz1_build_lib");
