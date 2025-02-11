Future<void> main() async {
  await Supabase.initialize(
    url: 'https://uircffonnfpqthyvynnn.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpcmNmZm9ubmZwcXRoeXZ5bm5uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg4NTk2NjAsImV4cCI6MjA1NDQzNTY2MH0.CgoJnyczG9lnp9Ln7RZ23ooaMeL9QmaydzkLpHwN4UU',
  );

  runApp(MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;
