import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../widgets/header/custom_header.dart';
import '../widgets/footer/custom_footer.dart';
import '../widgets/blogs/blog_card.dart';
import '../models/blog_model.dart';
import '../utils/constants.dart';
import '../utils/blog_data.dart';

class BlogDetailScreen extends StatefulWidget {
  final Blog blog;

  const BlogDetailScreen({
    super.key,
    required this.blog,
  });

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  List<Blog> _relatedBlogs = [];
  bool _isLoadingRelated = true;

  @override
  void initState() {
    super.initState();
    _fetchRelatedBlogs();
  }

  Future<void> _fetchRelatedBlogs() async {
    try {
      final response = await http.get(
        Uri.parse(blogApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> blogsJson = json.decode(response.body);
        final allBlogs = blogsJson.map((json) => Blog.fromJson(json)).toList();

        // Filter out current blog and take first 3
        final related =
            allBlogs.where((b) => b.id != widget.blog.id).take(3).toList();

        if (mounted) {
          setState(() {
            _relatedBlogs = related;
            _isLoadingRelated = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching related blogs: $e');
      if (mounted) {
        setState(() {
          _isLoadingRelated = false;
        });
      }
    }
  }

  // Get article URL for sharing
  String _getArticleUrl() {
    // Using slug if available, fallback to id
    if (widget.blog.slug.isNotEmpty) {
      return 'https://toyvista.com/blog/${widget.blog.slug}';
    }
    return 'https://toyvista.com/blog/${widget.blog.id}';
  }

  // Share to Facebook
  Future<void> _shareToFacebook() async {
    final url = _getArticleUrl();
    final shareUrl =
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}';

    try {
      if (await canLaunchUrl(Uri.parse(shareUrl))) {
        await launchUrl(
          Uri.parse(shareUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      _showErrorSnackBar('Could not open Facebook');
    }
  }

  // Share to Twitter/X
  Future<void> _shareToTwitter() async {
    final url = _getArticleUrl();
    final text = 'Check out this article: ${widget.blog.title}';
    final shareUrl =
        'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(text)}&url=${Uri.encodeComponent(url)}';

    try {
      if (await canLaunchUrl(Uri.parse(shareUrl))) {
        await launchUrl(
          Uri.parse(shareUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      _showErrorSnackBar('Could not open Twitter');
    }
  }

  // Share via Email
  Future<void> _shareViaEmail() async {
    final url = _getArticleUrl();
    final subject = 'Check out this article: ${widget.blog.title}';
    final body = 'I thought you might like this article: $url';
    final shareUrl =
        'mailto:?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';

    try {
      if (await canLaunchUrl(Uri.parse(shareUrl))) {
        await launchUrl(
          Uri.parse(shareUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      _showErrorSnackBar('Could not open email app');
    }
  }

  // Copy link to clipboard
  Future<void> _copyLink() async {
    final url = _getArticleUrl();
    await Clipboard.setData(ClipboardData(text: url));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Link copied to clipboard!'),
        backgroundColor: toyBlue,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  // Share to Pinterest
  Future<void> _shareToPinterest() async {
    final url = _getArticleUrl();
    final imageUrl = widget.blog.imageUrl;
    final description = widget.blog.title;
    final shareUrl =
        'https://pinterest.com/pin/create/button/?url=${Uri.encodeComponent(url)}&media=${Uri.encodeComponent(imageUrl)}&description=${Uri.encodeComponent(description)}';

    try {
      if (await canLaunchUrl(Uri.parse(shareUrl))) {
        await launchUrl(
          Uri.parse(shareUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      _showErrorSnackBar('Could not open Pinterest');
    }
  }

  // Share to LinkedIn
  Future<void> _shareToLinkedIn() async {
    final url = _getArticleUrl();
    final shareUrl =
        'https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeComponent(url)}';

    try {
      if (await canLaunchUrl(Uri.parse(shareUrl))) {
        await launchUrl(
          Uri.parse(shareUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      _showErrorSnackBar('Could not open LinkedIn');
    }
  }

  // Share to WhatsApp
  Future<void> _shareToWhatsApp() async {
    final url = _getArticleUrl();
    final text = 'Check out this article: ${widget.blog.title} - $url';
    final shareUrl = 'https://wa.me/?text=${Uri.encodeComponent(text)}';

    try {
      if (await canLaunchUrl(Uri.parse(shareUrl))) {
        await launchUrl(
          Uri.parse(shareUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      _showErrorSnackBar('Could not open WhatsApp');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Parse HTML content to maintain image-text relationships
  List<Widget> _parseContent(String htmlContent) {
    List<Widget> widgets = [];

    // First, decode HTML entities
    htmlContent = htmlContent
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&nbsp;', ' ');

    // Split content by lines to process sequentially
    List<String> lines = htmlContent.split('\n');

    for (String line in lines) {
      line = line.trim();
      if (line.isEmpty) continue;

      // Check for images
      if (line.contains('<img')) {
        final RegExp srcRegex = RegExp(r'src="([^"]+)"');
        final match = srcRegex.firstMatch(line);
        if (match != null) {
          String imageUrl = match.group(1)!;
          widgets.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.broken_image,
                              color: Colors.grey, size: 50),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
      }
      // Check for headers with links (like product links)
      else if (line.contains('<h2') && line.contains('<a')) {
        final RegExp linkRegex =
            RegExp(r'<a[^>]*href="([^"]+)"[^>]*>(.*?)</a>');
        final match = linkRegex.firstMatch(line);
        if (match != null) {
          String linkUrl = match.group(1)!;
          String linkText = match.group(2)!.replaceAll(RegExp(r'<[^>]+>'), '');

          widgets.add(
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              child: GestureDetector(
                onTap: () async {
                  if (await canLaunchUrl(Uri.parse(linkUrl))) {
                    launchUrl(Uri.parse(linkUrl));
                  }
                },
                child: Text(
                  linkText,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          );
        }
      }
      // Check for regular headers
      else if (line.contains('<h2')) {
        String headerText = line.replaceAll(RegExp(r'<[^>]+>'), '').trim();
        if (headerText.isNotEmpty) {
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              child: Text(
                headerText,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
          );
        }
      }
      // Check for paragraphs with strong/bold text
      else if (line.contains('<p') ||
          line.contains('<strong') ||
          line.contains('<em')) {
        String cleanText = line.replaceAll(RegExp(r'<[^>]+>'), '').trim();
        if (cleanText.isNotEmpty) {
          // Check if this is an age line (contains "Age:")
          if (cleanText.contains('Age:')) {
            widgets.add(
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 12),
                child: Text(
                  cleanText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
            );
          } else {
            widgets.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  cleanText,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Color(0xFF334155),
                  ),
                ),
              ),
            );
          }
        }
      }
      // Regular text
      else {
        String cleanText = line.replaceAll(RegExp(r'<[^>]+>'), '').trim();
        if (cleanText.isNotEmpty) {
          // Check if it's a numbered item (like "1. Soft Plush Toys")
          if (RegExp(r'^\d+\.').hasMatch(cleanText)) {
            widgets.add(
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Text(
                  cleanText,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
            );
          } else {
            widgets.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  cleanText,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Color(0xFF334155),
                  ),
                ),
              ),
            );
          }
        }
      }
    }

    return widgets;
  }

  // Extract tags from content
  List<String> _extractTags() {
    // You can customize this based on your data
    return ['#Best', '#Gifts', '#Newborn'];
  }

  @override
  Widget build(BuildContext context) {
    final tags = _extractTags();
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(showSearchBar: false),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // Main Content Container
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 900,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 40 : 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            widget.blog.title,
                            style: TextStyle(
                              fontSize: isDesktop ? 36 : 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E293B),
                              height: 1.2,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Date and read time
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.blog.formattedDate,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.blog.readTime,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Featured Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              widget.blog.imageUrl,
                              height: isDesktop ? 400 : 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: isDesktop ? 400 : 300,
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported,
                                        size: 50, color: Colors.grey),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Blog Content
                          ..._parseContent(widget.blog.content),

                          const SizedBox(height: 32),

                          // Article Tags
                          if (tags.isNotEmpty) ...[
                            const Text(
                              'Article Tags',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: tags
                                  .map((tag) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEFF6FF),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: const Color(0xFFDBEAFE)),
                                        ),
                                        child: Text(
                                          tag,
                                          style: const TextStyle(
                                            color: Color(0xFF2563EB),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],

                          const SizedBox(height: 32),

                          // Share Section
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(16),
                              border:
                                  Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Share this article',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Help others discover this content',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Social Media Icons Row
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      _buildShareButton(
                                        icon: Icons.facebook,
                                        color: const Color(0xFF1877F2),
                                        label: 'Facebook',
                                        onTap: _shareToFacebook,
                                      ),
                                      const SizedBox(width: 12),
                                      _buildShareButton(
                                        icon: Icons.alternate_email,
                                        color: const Color(0xFF1DA1F2),
                                        label: 'Twitter',
                                        onTap: _shareToTwitter,
                                      ),
                                      // const SizedBox(width: 12),
                                      // _buildShareButton(
                                      //   icon: Icons.pinterest,
                                      //   color: const Color(0xFFE60023),
                                      //   label: 'Pinterest',
                                      //   onTap: _shareToPinterest,
                                      // ),
                                      // const SizedBox(width: 12),
                                      _buildShareButton(
                                        icon: Icons.email,
                                        color: const Color(0xFFEA4335),
                                        label: 'Email',
                                        onTap: _shareViaEmail,
                                      ),
                                      const SizedBox(width: 12),
                                      _buildShareButton(
                                        icon: Icons.link,
                                        color: const Color(0xFF64748B),
                                        label: 'Copy',
                                        onTap: _copyLink,
                                      ),
                                      const SizedBox(width: 12),
                                      _buildShareButton(
                                        icon: Icons.message,
                                        color: const Color(0xFF25D366),
                                        label: 'WhatsApp',
                                        onTap: _shareToWhatsApp,
                                      ),
                                      const SizedBox(width: 12),
                                      _buildShareButton(
                                        icon: Icons.business,
                                        color: const Color(0xFF0A66C2),
                                        label: 'LinkedIn',
                                        onTap: _shareToLinkedIn,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Related Articles Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Related Articles',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: toyBlue,
                                ),
                                child: const Row(
                                  children: [
                                    Text('View All'),
                                    SizedBox(width: 4),
                                    Icon(Icons.arrow_forward, size: 16),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Related Articles List
                          if (_isLoadingRelated)
                            const Center(child: CircularProgressIndicator())
                          else if (_relatedBlogs.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _relatedBlogs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _buildRelatedBlogCard(
                                      _relatedBlogs[index]),
                                );
                              },
                            ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),

                  const CustomFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedBlogCard(Blog blog) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailScreen(blog: blog),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.network(
                blog.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.image, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 10, color: Colors.grey[400]),
                        const SizedBox(width: 4),
                        Text(
                          blog.formattedDate,
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[500]),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.access_time,
                            size: 10, color: Colors.grey[400]),
                        const SizedBox(width: 4),
                        Text(
                          blog.readTime,
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
