/**
 * FIND MY CLASSROOM - CAMPUS NAVIGATOR
 * Client-Side JavaScript for Validation, Interactivity & Map View
 */

document.addEventListener("DOMContentLoaded", function () {
    // 1. Auto-dismiss alerts after 5 seconds
    const alerts = document.querySelectorAll(".alert-dismissible");
    alerts.forEach(function (alert) {
        setTimeout(function () {
            const bsAlert = bootstrap.Alert.getOrCreateInstance(alert);
            if (bsAlert) {
                bsAlert.close();
            }
        }, 5000);
    });

    // 2. Real-time Live Table Filter
    const liveSearchInput = document.getElementById("tableSearchInput");
    if (liveSearchInput) {
        liveSearchInput.addEventListener("keyup", function () {
            const filter = this.value.toLowerCase();
            const rows = document.querySelectorAll(".filterable-table tbody tr");
            rows.forEach(function (row) {
                const text = row.textContent.toLowerCase();
                row.style.display = text.indexOf(filter) > -1 ? "" : "none";
            });
        });
    }

    // 3. Register Form Validation
    const registerForm = document.getElementById("registerForm");
    if (registerForm) {
        registerForm.addEventListener("submit", function (e) {
            const pwd = document.getElementById("password").value;
            const confirmPwd = document.getElementById("confirmPassword").value;
            const clientMsg = document.getElementById("clientValidationMsg");

            if (pwd.length < 6) {
                e.preventDefault();
                if (clientMsg) {
                    clientMsg.textContent = "Password must be at least 6 characters long.";
                    clientMsg.classList.remove("d-none");
                }
                return false;
            }

            if (pwd !== confirmPwd) {
                e.preventDefault();
                if (clientMsg) {
                    clientMsg.textContent = "Passwords do not match! Please check again.";
                    clientMsg.classList.remove("d-none");
                }
                return false;
            }
        });
    }
});

/**
 * Quick Fill Demo Credentials on the Login Page
 */
function fillDemoCredentials(role) {
    const userField = document.getElementById("username");
    const passField = document.getElementById("password");

    if (!userField || !passField) return;

    if (role === 'admin') {
        userField.value = "admin";
        passField.value = "admin123";
    } else if (role === 'staff') {
        userField.value = "staff";
        passField.value = "staff123";
    } else if (role === 'student') {
        userField.value = "student";
        passField.value = "student123";
    }
}

/**
 * Confirmation dialog helper
 */
function confirmAction(message) {
    return confirm(message || "Are you sure you want to proceed with this action?");
}

/**
 * Interactive Campus Map block info modal display
 */
function showBlockDetails(blockName, departments, features) {
    const titleEl = document.getElementById("blockModalTitle");
    const deptsEl = document.getElementById("blockModalDepts");
    const featsEl = document.getElementById("blockModalFeatures");
    const searchLink = document.getElementById("blockModalSearchLink");

    if (titleEl) titleEl.textContent = blockName;
    if (deptsEl) deptsEl.textContent = departments;
    if (featsEl) featsEl.textContent = features;
    if (searchLink) {
        searchLink.href = "find-classroom?block=" + encodeURIComponent(blockName);
    }

    const modalEl = document.getElementById("blockDetailsModal");
    if (modalEl) {
        const modal = new bootstrap.Modal(modalEl);
        modal.show();
    }
}
