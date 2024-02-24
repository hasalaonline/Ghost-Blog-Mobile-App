import 'package:flutter/material.dart';
import 'package:ghost_blog/screens/postsScreen';
import 'package:html/parser.dart' as htmlParser;

class PostDetailsScreen extends StatelessWidget {
  final Post post;

  PostDetailsScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the feature image
              if (post.featureImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius as needed
                  child: Image.network(
                    post.featureImage!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 8),
              Text('Published on: ${formatDate(post.publishedAt)}',
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Text(
                post.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(plainTextContentSnippet(
                  post)), // or use post.plainTextContentSnippet if you want a snippet
            ],
          ),
        ),
      ),
    );
  }
}

String plainTextContentSnippet(Post post) {
  // Use the html package to parse HTML and get plain text snippet
  final document = htmlParser.parse(post.htmlContent);
  final text = document.body?.text;
  return text ?? ''; // Adjust the length as needed
}
