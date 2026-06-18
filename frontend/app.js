// ============================================================
// E-Commerce Analytics Dashboard — app.js
// Fetches from Flask API and renders KPIs + Charts
// ============================================================

const API = "http://127.0.0.1:5000/api";

// ── Theme Toggle ─────────────────────────────────────────────
function initThemeToggle() {
  const btn = document.getElementById("themeToggle");
  const html = document.documentElement;
  btn.addEventListener("click", () => {
    const isDark = html.getAttribute("data-theme") === "dark";
    html.setAttribute("data-theme", isDark ? "light" : "dark");
    btn.textContent = isDark ? "☀️ Light Mode" : "🌙 Dark Mode";
  });
}

// ── KPI Cards ────────────────────────────────────────────────
async function loadKPIs() {
  try {
    const res  = await fetch(`${API}/kpis`);
    const data = await res.json();

    document.getElementById("kpi-orders").textContent =
      Number(data.total_orders).toLocaleString();

    document.getElementById("kpi-revenue").textContent =
      "$" + Number(data.total_revenue).toLocaleString("en-US", {
        minimumFractionDigits: 0, maximumFractionDigits: 0
      });

    document.getElementById("kpi-delivery").textContent =
      data.avg_delivery_days + " days";

    document.getElementById("kpi-late").textContent =
      data.late_delivery_rate + "%";

    document.getElementById("kpi-review").textContent =
      "⭐ " + data.avg_review_score;

  } catch (err) {
    console.error("KPI fetch failed:", err);
  }
}

// ── Monthly Orders Line Chart ─────────────────────────────────
async function loadMonthlyOrders() {
  try {
    const res  = await fetch(`${API}/monthly-orders`);
    const data = await res.json();

    const labels   = data.map(d => d.order_month);
    const orders   = data.map(d => d.total_orders);
    const revenues = data.map(d => d.total_revenue);

    // Find peak month for badge
    const maxOrders = Math.max(...orders);
    const peakMonth = labels[orders.indexOf(maxOrders)];
    document.getElementById("badge-peak-month").textContent =
      "Peak: " + peakMonth;

    const ctx = document.getElementById("chart-monthly-orders").getContext("2d");
    new Chart(ctx, {
      type: "line",
      data: {
        labels,
        datasets: [{
          label: "Total Orders",
          data: orders,
          borderColor: "#4f8ef7",
          backgroundColor: "rgba(79,142,247,0.1)",
          borderWidth: 2,
          pointRadius: 3,
          fill: true,
          tension: 0.4
        }]
      },
      options: {
        responsive: true,
        plugins: { legend: { display: false } },
        scales: {
          x: {
            ticks: { color: "#8892b0", maxTicksLimit: 10 },
            grid:  { color: "rgba(255,255,255,0.05)" }
          },
          y: {
            ticks: { color: "#8892b0" },
            grid:  { color: "rgba(255,255,255,0.05)" }
          }
        }
      }
    });
  } catch (err) {
    console.error("Monthly orders fetch failed:", err);
  }
}

// ── Category Revenue Bar Chart ────────────────────────────────
async function loadCategoryRevenue() {
  try {
    const res  = await fetch(`${API}/category-revenue`);
    const data = await res.json();

    const labels   = data.map(d =>
      d.product_category.replace(/_/g, " ")
    );
    const revenues = data.map(d => d.total_revenue);

    const ctx = document.getElementById("chart-category-revenue").getContext("2d");
    new Chart(ctx, {
      type: "bar",
      data: {
        labels,
        datasets: [{
          label: "Revenue (R$)",
          data: revenues,
          backgroundColor: "rgba(79,142,247,0.75)",
          borderRadius: 4
        }]
      },
      options: {
        indexAxis: "y",
        responsive: true,
         maintainAspectRatio: false, 
        plugins: { legend: { display: false } },
        scales: {
          x: {
            ticks: { color: "#8892b0" },
            grid:  { color: "rgba(255,255,255,0.05)" }
          },
          y: {
            ticks: { color: "#8892b0", font: { size: 11 } },
            grid:  { display: false }
          }
        }
      }
    });
  } catch (err) {
    console.error("Category revenue fetch failed:", err);
  }
}

// ── Payment Methods Doughnut Chart ───────────────────────────
async function loadPaymentSummary() {
  try {
    const res  = await fetch(`${API}/payment-summary`);
    const data = await res.json();

    const labels = data.map(d =>
      d.payment_type.replace(/_/g, " ").replace(/\b\w/g, c => c.toUpperCase())
    );
    const values = data.map(d => d.total_orders);

    const ctx = document.getElementById("chart-payment").getContext("2d");
    new Chart(ctx, {
      type: "doughnut",
      data: {
        labels,
        datasets: [{
          data: values,
          backgroundColor: ["#4f8ef7", "#2ecc71", "#f39c12", "#e74c3c"],
          borderWidth: 2,
          borderColor: "#1e2235"
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false, 
        plugins: {
          legend: {
            position: "bottom",
            labels: { color: "#8892b0", padding: 15, font: { size: 12 } }
          }
        }
      }
    });
  } catch (err) {
    console.error("Payment summary fetch failed:", err);
  }
}

// ── Review vs Delivery Bar Chart ─────────────────────────────
async function loadReviewDelivery() {
  try {
    const res  = await fetch(`${API}/review-delivery`);
    const data = await res.json();

    const labels = data.map(d =>
      d.delivery_status === "Yes" ? "Late Delivery" : "On-Time Delivery"
    );
    const scores = data.map(d => d.avg_review_score);

    const ctx = document.getElementById("chart-review-delivery").getContext("2d");
    new Chart(ctx, {
      type: "bar",
      data: {
        labels,
        datasets: [{
          label: "Avg Review Score",
          data: scores,
          backgroundColor: ["#2ecc71", "#e74c3c"],
          borderRadius: 6
        }]
      },
      options: {
        responsive: true,
        plugins: { legend: { display: false } },
        scales: {
          y: {
            min: 0, max: 5,
            ticks: { color: "#8892b0" },
            grid:  { color: "rgba(255,255,255,0.05)" }
          },
          x: {
            ticks: { color: "#8892b0" },
            grid:  { display: false }
          }
        }
      }
    });
  } catch (err) {
    console.error("Review delivery fetch failed:", err);
  }
}

// ── State Delivery Table ─────────────────────────────────────
async function loadStateDelivery() {
  try {
    const res  = await fetch(`${API}/state-delivery`);
    const data = await res.json();

    const tbody = document.getElementById("state-table-body");
    tbody.innerHTML = "";

    data.forEach(row => {
      const lateRate = parseFloat(row.late_delivery_rate);
      const rateClass = lateRate > 15 ? "rate-high"
                      : lateRate > 8  ? "rate-medium"
                      : "rate-low";

      tbody.innerHTML += `
        <tr>
          <td><strong>${row.customer_state}</strong></td>
          <td>${Number(row.total_orders).toLocaleString()}</td>
          <td>${row.avg_delivery_days} days</td>
          <td class="${rateClass}">${lateRate}%</td>
        </tr>`;
    });
  } catch (err) {
    console.error("State delivery fetch failed:", err);
  }
}

// ── Add rate color classes to CSS ────────────────────────────
// (These classes are used in the table above)
// Add these to style.css manually (listed in Step 3 below)

// ── Init ─────────────────────────────────────────────────────
document.addEventListener("DOMContentLoaded", () => {
  initThemeToggle();
  loadKPIs();
  loadMonthlyOrders();
  loadCategoryRevenue();
  loadPaymentSummary();
  loadReviewDelivery();
  loadStateDelivery();
});